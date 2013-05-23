#import "BLStoreManager.h"
#import "SettingsStore.h"
#import "WorkoutStore.h"
#import "SetStore.h"
#import "SSLiftStore.h"
#import "SSWorkoutStore.h"
#import "ContextManager.h"

@implementation BLStoreManager
@synthesize allStores;

- (void)initializeAllStores {
    allStores = @[
            [SettingsStore instance],
            [WorkoutStore instance],
            [SetStore instance],
            [SSLiftStore instance],
            [SSWorkoutStore instance]
    ];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataModelChange:)
                                                 name:NSManagedObjectContextObjectsDidChangeNotification
                                               object:[ContextManager context]];
}

- (void)handleDataModelChange:(id)note {
    NSSet *updatedObjects = [[note userInfo] objectForKey:NSUpdatedObjectsKey];
    NSSet *deletedObjects = [[note userInfo] objectForKey:NSDeletedObjectsKey];
    NSSet *insertedObjects = [[note userInfo] objectForKey:NSInsertedObjectsKey];

    NSSet *allObjects = [[updatedObjects setByAddingObjectsFromSet:deletedObjects] setByAddingObjectsFromSet:insertedObjects];
    for (BLStore *store in [self getChangedStoresFromObjects:allObjects]) {
        [store fireChanged];
    }
}

- (NSSet *)getChangedStoresFromObjects:(NSSet *)allObjects {
    NSMutableSet *changedModelNames = [self getChangedModelNames:allObjects];

    NSMutableDictionary *storeModelMapping = [@{} mutableCopy];
    for (BLStore *store in allStores) {
        [storeModelMapping setObject:store forKey:[store modelName]];
    }

    NSMutableSet *changedStores = [NSMutableSet new];
    for (NSString *modelName in changedModelNames) {
        [changedStores addObject:storeModelMapping[modelName]];
    }

    return changedStores;
}

- (NSMutableSet *)getChangedModelNames:(NSSet *)allObjects {
    NSMutableSet *changedModelNames = [NSMutableSet new];
    for (NSManagedObject *object in allObjects) {
        [changedModelNames addObject:[[object entity] name]];
    }
    return changedModelNames;
}

+ (BLStoreManager *)instance {
    static BLStoreManager *manager = nil;

    if (!manager) {
        manager = [BLStoreManager new];
    }

    return manager;
}

@end