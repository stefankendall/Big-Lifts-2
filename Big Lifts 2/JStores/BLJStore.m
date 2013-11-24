#import <JSONModel/JSONModel.h>
#import "NSArray+Enumerable.h"
#import "BLJStore.h"

@implementation BLJStore

- (Class)modelClass {
    [NSException raise:@"Must implement" format:@""];
}

- (NSString *)modelName {
    NSString *className = NSStringFromClass([self class]);
    return [className substringToIndex:([className rangeOfString:@"Store"]).location];
}

- (id)create {
    NSObject *object = [[self modelClass] new];
    [self.data addObject:object];
    return object;
}

- (void)empty {
    self.data = [@[] mutableCopy];
}

- (void)remove:(id)object {
    [self.data removeObject:object];
}

- (void)reset {
    [self empty];
    [self setupDefaults];
}

- (id)first {
    return [self count] == 0 ? nil : [self findAll][0];
}

- (id)last {
    return [self count] == 0 ? nil : [[self findAll] lastObject];
}

- (id)find:(NSString *)name value:(id)value {
    return [self findBy:[NSPredicate predicateWithFormat:@"%K == %@", name, value]];
}

- (NSArray *)findAll {
    NSSortDescriptor *order = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
    return [self.data sortedArrayUsingDescriptors:@[order]];
}

- (NSArray *)findAllWhere:(NSString *)name value:(id)value {
    NSArray *all = [self findAll];
    return [all filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", name, value]];
}

- (NSArray *)findAllWithSort:(NSSortDescriptor *)sortDescriptor {
    NSArray *sortDescriptors = @[sortDescriptor];
    return [[self findAll] sortedArrayUsingDescriptors:sortDescriptors];
}

- (id)findBy:(NSPredicate *)predicate {
    NSArray *all = [self findAll];
    NSArray *results = [all filteredArrayUsingPredicate:predicate];
    if (results.count != 1) {
        return nil;
    }

    return results[0];
}

- (id)atIndex:(int)index {
    return [self findAll][(NSUInteger) index];
}

- (NSNumber *)max:(NSString *)property {
    NSArray *allValues = [[self findAll] collect:^id(id obj) {
        return [obj valueForKeyPath:property];
    }];
    NSArray *sorted = [allValues sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    if ([sorted count] > 0) {
        return [sorted lastObject];
    }
    else {
        return nil;
    }
}

- (void)removeAtIndex:(int)index {
};

- (int)count {
    return [[self findAll] count];
}

- (NSOrderedSet *)unique:(NSString *)keyName {
    NSArray *allValues = [[self findAll] collect:^id(id obj) {
        id value = [obj valueForKeyPath:keyName];
        if (value == nil ) {
            value = [NSNull null];
        }
        return value;
    }];

    return [[NSOrderedSet alloc] initWithArray:allValues];
}


+ (instancetype)instance {
    static NSMutableDictionary *stores = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        stores = [@{} mutableCopy];
    });

    NSString *key = NSStringFromClass([self class]);
    if (![stores objectForKey:key]) {
        BLJStore *store = [self new];
        [stores setObject:store forKey:key];
        if ([store count] == 0) {
            [store setupDefaults];
        }
        [store onLoad];
    }

    return [stores objectForKey:key];
}

- (void)onLoad {
}

- (void)sync {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    [keyValueStore setObject:[self serialize] forKey:[self keyNameForStore]];
    [keyValueStore synchronize];
}

- (NSArray *)serialize {
    NSMutableArray *serialized = [@[] mutableCopy];
    for (JSONModel *model in self.data) {
        [serialized addObject:[model toJSONString]];
    }
    return serialized;
}

- (NSString *)keyNameForStore {
    return [[self modelName] stringByAppendingString:@"Store"];
}

- (void)load {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    NSArray *serializedData = [keyValueStore arrayForKey:[self keyNameForStore]];
    self.data = [self deserialize:serializedData];
}

- (NSMutableArray *)deserialize:(NSArray *)serialized {
    NSMutableArray *deserialized = [@[] mutableCopy];
    for (NSString *string in serialized) {
        JSONModel *model = [[[self modelClass] alloc] initWithString:string error:nil];
        [deserialized addObject:model];
    }
    return deserialized;
}

- (void)setupDefaults {
}

@end