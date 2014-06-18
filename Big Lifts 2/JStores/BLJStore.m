#import <Crashlytics/Crashlytics.h>
#import "JModel.h"
#import "NSArray+Enumerable.h"
#import "BLJStore.h"
#import "JSONModelClassProperty.h"
#import "BLJStoreManager.h"
#import "BLKeyValueStore.h"

@implementation BLJStore

- (Class)modelClass {
    [NSException raise:@"Must implement" format:@""];
}

- (id)create {
    JModel *object = [[self modelClass] new];
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
    self.uuidCache = [@{} mutableCopy];
}

- (void)removeAll {
    while ([self.data count] > 0) {
        id object = self.data[0];
        [self remove:object];
    }
}

- (void)remove:(id)object {
    [self.data removeObject:object];
    [self.uuidCache removeObjectForKey:[object uuid]];
    [self removeCascadeAssociations:object];
}

- (void)removeCascadeAssociations:(JModel *)model {
    for (JSONModelClassProperty *p in [model __properties__]) {
        id value = [model valueForKey:p.name];
        if (isNull(value)) {
            continue;
        }

        if ([value isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *) value;
            for (JModel *association in array) {
                if (![self model:model shouldDeleteAssociation:p]) {
                    break;
                }
                [self removeModelFromItsStore:association];
            }
        }
        else if ([value isKindOfClass:JModel.class]) {
            JModel *valueModel = value;
            if ([self model:model shouldDeleteAssociation:p]) {
                [self removeModelFromItsStore:valueModel];
            }
        }
    }
}

- (BOOL)model:(JModel *)model shouldDeleteAssociation:(JSONModelClassProperty *)p {
    return [[model cascadeDeleteProperties] containsObject:p.name];
}

- (void)removeModelFromItsStore:(JModel *)model {
    BLJStore *store = [[BLJStoreManager instance] storeForModel:model.class withUuid:model.uuid];
    [store remove:model];
}

- (void)removeAtIndex:(int)index {
    [self remove:[self.findAll objectAtIndex:(NSUInteger) index]];
};

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
    if ([name isEqualToString:@"uuid"]) {
        JModel *cachedModel = [self.uuidCache objectForKey:value];
        if (cachedModel) {
            return cachedModel;
        }
    }
    return [self findBy:[NSPredicate predicateWithFormat:@"%K == %@", name, value]];
}

- (NSArray *)findAll {
    if ([[self modelClass] instancesRespondToSelector:@selector(order)]) {
        NSSortDescriptor *order = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
        return [self.data sortedArrayUsingDescriptors:@[order]];
    }
    else {
        return self.data;
    }
}

- (NSArray *)findAllWhere:(NSString *)name value:(id)value {
    NSArray *all = [self findAll];
    return [all filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", name, value]];
}

- (id)findBy:(NSPredicate *)predicate {
    NSArray *all = [self findAll];
    NSArray *results = [all filteredArrayUsingPredicate:predicate];
    if (results.count == 0) {
        return nil;
    }

    return results[0];
}

- (id)atIndex:(int)index {
    NSArray *all = [self findAll];
    if (index < 0 || index >= [all count]) {
        return nil;
    }
    return all[(NSUInteger) index];
}

- (NSNumber *)max:(NSString *)property {
    if ([self count] == 0) {
        return nil;
    }

    NSArray *allValues = [[self findAll] collect:^id(id obj) {
        id value = [obj valueForKeyPath:property];
        return value ? value : [NSNull new];
    }];
    NSArray *sorted = [allValues sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 isEqual:[NSNull new]] && [obj2 isEqual:[NSNull new]]) {
            return NSOrderedSame;
        }
        else if ([obj1 isEqual:[NSNull new]]) {
            return NSOrderedAscending;
        }
        else if ([obj2 isEqual:[NSNull new]]) {
            return NSOrderedDescending;
        }

        return [obj1 compare:obj2];
    }];

    return [[sorted lastObject] isEqual:[NSNull new]] ? nil : [sorted lastObject];
}

- (int)count {
    return [[self findAll] count];
}

- (NSOrderedSet *)unique:(NSString *)keyName {
    NSArray *allValues = [[self findAll] collect:^id(id obj) {
        id value = [obj valueForKeyPath:keyName];
        if (value == nil) {
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
    }

    return [stores objectForKey:key];
}

- (void)onLoad {
}

- (void)sync {
    NSArray *serialized = [self serialize];
    NSString *storeKey = [self keyNameForStore];
    [[BLKeyValueStore store] setObject:serialized forKey:storeKey];
}

- (NSArray *)serialize {
    NSMutableArray *serialized = [@[] mutableCopy];
    for (JSONModel *model in self.data) {
        NSString *serialModel = [model toJSONString];
        if (serialModel != nil) {
            [serialized addObject:serialModel];
        }
        else {
            CLS_LOG(@"%@", model);
            [NSException raise:@"Could not serialize model." format:@""];
        }
    }
    return serialized;
}

- (NSString *)keyNameForStore {
    return NSStringFromClass([self class]);
}

- (void)load {
    NSUbiquitousKeyValueStore *keyValueStore = [BLKeyValueStore store];
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
    [self buildUuidCache];
    [self onLoad];
}

- (void)buildUuidCache {
    self.uuidCache = [@{} mutableCopy];
    for (JModel *model in self.data) {
        self.uuidCache[model.uuid] = model;
    }
}

- (NSMutableArray *)deserialize:(NSArray *)serialized {
    NSMutableArray *deserialized = [@[] mutableCopy];
    for (NSString *string in serialized) {
        CLS_LOG("Deserialize: %@", string);
        JSONModel *model = [self deserializeObject:string];
        if (model != nil) {
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