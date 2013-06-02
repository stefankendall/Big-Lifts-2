#import "BLStore.h"
#import "ContextManager.h"

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
    return [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[ContextManager context]];
}

- (void)contentChange:(NSNotification *)note {
    [[ContextManager context] mergeChangesFromContextDidSaveNotification:note];
}

- (void)empty {
    NSFetchRequest *request = [self getRequest];
    for (NSManagedObject *object in [[ContextManager context] executeFetchRequest:request error:nil]) {
        [[ContextManager context] deleteObject:object];
    }
}

- (NSFetchRequest *)getRequest {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[[ContextManager model] entitiesByName] objectForKey:[self modelName]];
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
    if ([self count] == 0) {
        return nil;
    }
    else {
        return [self findAll][0];
    }
}

- (NSArray *)findAll {
    NSFetchRequest *request = [self getRequest];
    if ([[[request entity] propertiesByName] objectForKey:@"order"]) {
        [request setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
    }

    return [self executeRequest:request];
}

- (NSArray *)findAllWithSort:(NSSortDescriptor *)sortDescriptor {
    NSFetchRequest *request = [self getRequest];
    [request setSortDescriptors:@[sortDescriptor]];
    return [self executeRequest:request];
}

- (NSArray *)executeRequest:(NSFetchRequest *)request {
    NSError *error;
    NSArray *result = [[ContextManager context] executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"%@", [error localizedDescription]];
    }

    return result;
}

- (id)findBy:(NSPredicate *)predicate {
    NSArray *all = [self findAll];
    NSArray *results = [all filteredArrayUsingPredicate:predicate];
    if (results.count != 1) {
        [NSException raise:@"Did not find exactly one record" format:@""];
    }

    return results[0];
}


- (id)atIndex:(int)index {
    return [self findAll][(NSUInteger) index];
};

- (int)count {
    return [[self findAll] count];
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