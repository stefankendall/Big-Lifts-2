#import <Crashlytics/Crashlytics.h>
#import "JModel.h"
#import "JSONModelClassProperty.h"
#import "BLJStore.h"
#import "BLJStoreManager.h"

@implementation JModel

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [[super toDictionary] mutableCopy];

    for (JSONModelClassProperty *p in [self __properties__]) {
        NSString *keyPath = p.name;
        id value = [self valueForKey:p.name];
        if (isNull(value)) {
            continue;
        }
        if ([value isKindOfClass:[JModel class]]) {
            JModel *model = value;
            [dictionary setValue:model.uuid forKeyPath:keyPath];
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
                    [newArray addObject:[object uuid]];
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

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError **)err {
    if (isNull(array)) return nil;
    NSMutableArray *list = [@[] mutableCopy];
    for (NSString *value in array) {
        BLJStore *store = [[BLJStoreManager instance] storeForModel:[self class] withUuid:value];
        id associatedObject = [store find:@"uuid" value:value];
        if (associatedObject) {
            [list addObject:associatedObject];
        }
        else {
            CLS_LOG(@"Loading model: %@, Could not load associated uuid: %@ for store: %@", NSStringFromClass([self class]),
                            value, NSStringFromClass([store class]));
            [NSException raise:@"Could not load assocation" format:@""];
        }
    }
    return list;
}

- (id)initWithDictionary:(id)possibleUuid error:(NSError **)err {
    if ([possibleUuid isKindOfClass:NSString.class]) {
        return [[BLJStoreManager instance] findModelForClass: [self class] withUuid: possibleUuid];
    }
    else {
        CLS_LOG(@"Deserializing: %@", possibleUuid);
        return [super initWithDictionary:possibleUuid error:err];
    }
}

- (NSArray *)cascadeDeleteProperties {
    return @[];
}


@end