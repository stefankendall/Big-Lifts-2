#import "BLStore.h"
#import "BLStoreManager.h"
#import "NSArray+Enumerable.h"

@implementation BLStore
@synthesize changeCallbacks;

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]
                addObserver:self
                   selector:@selector(contentChange:)
                       name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                     object:nil];

        changeCallbacks = [NSMutableSet new];
    }

    return self;
}


- (id)create {
    return [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[BLStoreManager context]];
}

- (void)contentChange:(NSNotification *)note {
    [[BLStoreManager context] mergeChangesFromContextDidSaveNotification:note];
}

- (void)empty {
    NSFetchRequest *request = [self getRequest];
    for (NSManagedObject *object in [[BLStoreManager context] executeFetchRequest:request error:nil]) {
        [[BLStoreManager context] deleteObject:object];
    }
}

- (void)remove:(id)object {
    [[BLStoreManager context] deleteObject:object];
}

- (NSFetchRequest *)getRequest {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[[BLStoreManager model] entitiesByName] objectForKey:[self modelName]];
    [request setEntity:entity];
    return request;
}

- (void)reset {
    [self empty];
    [self setupDefaults];
    changeCallbacks = [NSMutableSet new];
}

- (void)setupDefaults {
}


- (NSString *)modelName {
    NSString *className = NSStringFromClass([self class]);
    return [className substringToIndex:([className rangeOfString:@"Store"]).location];
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
    NSFetchRequest *request = [self getRequest];
    if ([[[request entity] propertiesByName] objectForKey:@"order"]) {
        [request setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
    }

    return [self executeRequest:request];
}

- (NSArray *)findAllWhere:(NSString *)name value:(id)value {
    NSArray *all = [self findAll];
    return [all filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", name, value]];
}

- (NSArray *)findAllWithSort:(NSSortDescriptor *)sortDescriptor {
    NSFetchRequest *request = [self getRequest];
    [request setSortDescriptors:@[sortDescriptor]];
    return [self executeRequest:request];
}

- (NSArray *)executeRequest:(NSFetchRequest *)request {
    NSError *error;
    NSArray *result = [[BLStoreManager context] executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"%@", [error localizedDescription]];
    }

    return result;
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
    [[BLStoreManager context] deleteObject:[self atIndex:index]];
};

- (int)count {
    return [[self findAll] count];
}

- (NSSet *)unique:(NSString *)keyName {
    NSArray *allValues = [[self findAll] collect:^id(id obj) {
        return [obj valueForKeyPath:keyName];
    }];

    return [[NSSet alloc] initWithArray:allValues];
}


+ (instancetype)instance {
    static NSMutableDictionary *stores = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        stores = [@{} mutableCopy];
    });

    NSString *key = NSStringFromClass([self class]);
    if (![stores objectForKey:key]) {
        BLStore *store = [self new];
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

- (void)fireChanged {
    for (
            void (^callback)()
            in changeCallbacks) {
        callback();
    }
}

- (void)registerChangeListener:(void (^)())callback {
    [changeCallbacks addObject:callback];
}


@end