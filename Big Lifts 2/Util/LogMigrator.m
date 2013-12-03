#import <UbiquityStoreManager/UbiquityStoreManager.h>
#import "LogMigrator.h"
#import "BLStoreManager.h"
#import "WorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "WorkoutLog.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "SetLog.h"

@interface LogMigrator ()
@property(nonatomic, strong) NSManagedObjectContext *moc;
@end

@implementation LogMigrator

- (void)migrate:(void (^)())doneCallback {
    self.doneCallback = doneCallback;
    [self initManager];
}

- (void)loadData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storesLoaded) name:@"storesLoaded" object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[BLStoreManager instance] initializeAllStores:self.moc withModel:[[self.moc persistentStoreCoordinator] managedObjectModel]];
    });
}

- (void)storesLoaded {
    for (WorkoutLog *workoutLog in [[WorkoutLogStore instance] findAll]) {
        JWorkoutLog *jWorkoutLog = [[JWorkoutLogStore instance] create];
        jWorkoutLog.name = workoutLog.name;
        jWorkoutLog.date = workoutLog.date;
        jWorkoutLog.deload = workoutLog.deload;

        for(SetLog *setLog in workoutLog.orderedSets){
            JSetLog *jSetLog = [[JSetLogStore instance] create];
            jSetLog.reps = setLog.reps;
            jSetLog.weight = setLog.weight;
            jSetLog.name = setLog.name;
            jSetLog.warmup = setLog.warmup;
            jSetLog.amrap = setLog.amrap;
        }
    }
    self.doneCallback();
}

- (void)initManager {
    self.manager = [[UbiquityStoreManager alloc] initStoreNamed:nil
                                         withManagedObjectModel:nil
                                                  localStoreURL:nil
                                            containerIdentifier:nil
                                         additionalStoreOptions:nil
                                                       delegate:self];
    self.manager.cloudEnabled = YES;
}

- (void)ubiquityStoreManager:(UbiquityStoreManager *)manager willLoadStoreIsCloud:(BOOL)isCloudStore {
    self.moc = nil;
}

- (BOOL)ubiquityStoreManager:(UbiquityStoreManager *)manager handleCloudContentCorruptionWithHealthyStore:(BOOL)storeHealthy {
    return NO;
}

- (void)ubiquityStoreManager:(UbiquityStoreManager *)manager didLoadStoreForCoordinator:(NSPersistentStoreCoordinator *)coordinator isCloud:(BOOL)isCloudStore {
    self.moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.moc setPersistentStoreCoordinator:coordinator];
    [self.moc setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    [self loadData];
}

- (NSManagedObjectContext *)managedObjectContextForUbiquityChangesInManager:(UbiquityStoreManager *)manager1 {
    return self.moc;
}

@end