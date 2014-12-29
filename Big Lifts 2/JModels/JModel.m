#import <Crashlytics/Crashlytics.h>
#import "JModel.h"
#import "JSONModelClassProperty.h"
#import "BLJStore.h"
#import "BLJStoreManager.h"

int const NOT_DEAD = 1;
int const DEAD = 2;

@implementation JModel

- (id)init {
    self = [super init];
    if (self) {
        self.dead = @(NOT_DEAD);
    }

    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [[super toDictionary] mutableCopy];

    for (JSONModelClassProperty *p in [self __properties__]) {
        NSString *keyPath = p.name;
        id value = [self valueForKey:p.name];
        if (isNull(value)) {
            continue;
        }
        if ([value isKindOfClass:[JModel class]]) {
            [dictionary setValue:[self serializeModel:value] forKeyPath:keyPath];
        }
        if ([value isKindOfClass:[NSDecimalNumber class]]) {
            if ([value isEqual:[NSDecimalNumber notANumber]]) {
                [dictionary setValue:N(0) forKey:keyPath];
            }
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *) value;
            NSMutableArray *newArray = [@[] mutableCopy];
            for (id object in array) {
                if ([object isKindOfClass:JModel.class]) {
                    [newArray addObject:[self serializeModel:object]];
                }
                else {
                    [newArray addObject:object];
                }
            }
            [dictionary setValue:newArray forKeyPath:keyPath];
        }
    }

    return [dictionary copy];
}

- (id)serializeModel:(id)value {
    NSString *uuid = [value uuid];
    if (![[BLJStoreManager instance] findModelForClass:[value class] withUuid:uuid]) {
        [NSException raise:@"Bad association" format:@""];
    }
    return uuid;
}

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError **)err {
    if (isNull(array)) return nil;
    NSMutableArray *list = [@[] mutableCopy];

    int nilCount = 0;
    for (NSString *value in array) {
        BLJStore *store = [[BLJStoreManager instance] storeForModel:[self class] withUuid:value];
        id object = [store find:@"uuid" value:value];
        if (object != nil) {
            [list addObject:object];
        }
        else {
            nilCount++;
        }
    }

    CLS_LOG(@"Nil count: %d", nilCount);

    return list;
}

- (id)initWithDictionary:(id)possibleUuid error:(NSError **)err {
    if ([possibleUuid isKindOfClass:NSString.class]) {
        return [[BLJStoreManager instance] findModelForClass:[self class] withUuid:possibleUuid];
    }
    else {
        CLS_LOG(@"Deserializing: %@", possibleUuid);
        return [super initWithDictionary:possibleUuid error:err];
    }
}

- (NSArray *)cascadeDeleteProperties {
    return @[];
}

- (BOOL)isDead {
    return [[self dead] intValue] == DEAD;
}

@end