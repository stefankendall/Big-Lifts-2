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
            NSLog(@"Loading model: %@, Could not load associated uuid: %@ for store: %@", NSStringFromClass([self class]),
                    value, NSStringFromClass([store class]));
        }
    }
    return list;
}

- (id)initWithDictionary:(id)possibleUuid error:(NSError **)err {
    if ([possibleUuid isKindOfClass:NSString.class]) {
        BLJStore *store = [[BLJStoreManager instance] storeForModel:[self class] withUuid:possibleUuid];
        return [store find:@"uuid" value:possibleUuid];
    }
    else {
        id jsonValue = nil;
        @try {
            jsonValue = [super initWithDictionary:possibleUuid error:err];
        }
        @catch (NSException *e) {
            NSLog(@"Could not deserialize: %@", possibleUuid);
        }
        return jsonValue;
    }
}

- (NSArray *)cascadeDeleteClasses {
    return @[];
}


@end