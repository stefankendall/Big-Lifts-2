#import "BLStoreManager.h"
#import "SettingsStore.h"
#import "WorkoutStore.h"
#import "SetStore.h"
#import "SSLiftStore.h"
#import "SSWorkoutStore.h"
#import "CurrentProgramStore.h"
#import "WorkoutLogStore.h"
#import "PlateStore.h"
#import "BarStore.h"
#import "SetLogStore.h"
#import "SSVariantStore.h"
#import "SSStateStore.h"
#import "FTOLiftStore.h"
#import "FTOWorkoutStore.h"
#import "FTOSetStore.h"
#import "FTOSettingsStore.h"
#import "FTOVariantStore.h"

@implementation BLStoreManager
@synthesize allStores;

+ (NSManagedObjectContext *)context {
    return [[BLStoreManager instance] context];
}

+ (NSManagedObjectModel *)model {
    return [[BLStoreManager instance] model];
}

- (void)initializeAllStores:(NSManagedObjectContext *)context withModel:(NSManagedObjectModel *)model {
    self.context = context;
    self.model = model;
    allStores = @[
            [CurrentProgramStore instance],
            [SettingsStore instance],
            [FTOSettingsStore instance],
            [BarStore instance],
            [WorkoutStore instance],
            [WorkoutLogStore instance],
            [SetStore instance],
            [FTOSetStore instance],
            [SSStateStore instance],
            [SSLiftStore instance],
            [SSVariantStore instance],
            [SSWorkoutStore instance],
            [FTOVariantStore instance],
            [FTOLiftStore instance],
            [FTOWorkoutStore instance],
            [PlateStore instance],
            [SetLogStore instance],
            [WorkoutLogStore instance]
    ];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataModelChange:)
                                                 name:NSManagedObjectContextObjectsDidChangeNotification
                                               object:context];
}

- (void)resetAllStores {
    for (BLStore *store in allStores) {
        [store empty];
    }

    for (BLStore *store in allStores) {
        [store setupDefaults];
    }
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
        id store = storeModelMapping[modelName];
        if (store == nil ) {
            NSLog(@"Store not defined: %@", modelName);
        }
        else {
            [changedStores addObject:store];
        }
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

- (void)saveChanges {
    NSError *err = nil;
    BOOL successful = [self.context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
}

@end