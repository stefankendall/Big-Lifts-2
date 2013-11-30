#import <JSONModel/JSONModel.h>
#import "NSArray+Enumerable.h"
#import "BLJStore.h"

@implementation BLJStore

- (Class)modelClass {
    [NSException raise:@"Must implement" format:@""];
}

- (id)create {
    NSObject *object = [[self modelClass] new];
    [self addUuid:object];
    [self.data addObject:object];
    [self setDefaultsForObject:object];
    return object;
}

- (void)addUuid:(NSObject *)object {
    if ([object respondsToSelector:@selector(uuid)]) {
        [object setValue:[[NSUUID UUID] UUIDString] forKey:@"uuid"];
    }
}

- (void)setDefaultsForObject:(id)object {
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
        id value = [obj valueForKeyPath:property];
        return value ? value : @-1;
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
    [self.data removeObjectAtIndex:(NSUInteger) index];
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
    return NSStringFromClass([self class]);
}

- (void)load {
    NSUbiquitousKeyValueStore *keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    NSArray *serializedData = [keyValueStore arrayForKey:[self keyNameForStore]];
    if (serializedData) {
        self.data = [self deserialize:serializedData];
    }
    else {
        self.data = [@[] mutableCopy];
    }

    if ([self.data count] == 0) {
        [self setupDefaults];
    }
}

- (NSMutableArray *)deserialize:(NSArray *)serialized {
    NSMutableArray *deserialized = [@[] mutableCopy];
    for (NSString *string in serialized) {
        JSONModel *model = [self deserializeObject:string];
        if (model != nil ) {
            [deserialized addObject:model];
        }
        else {
            NSLog(@"Could not deserialize: %@", string);
        }
    }
    return deserialized;
}

- (JSONModel *)deserializeObject:(NSString *)string {
    NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                             options:NSJSONReadingMutableContainers
                                               error:nil];
    JSONModel *model = [[[self modelClass] alloc] initWithDictionary:obj error:nil];
    return model;
}

- (void)setupDefaults {
}

@end