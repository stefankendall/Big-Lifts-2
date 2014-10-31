#import <Crashlytics/Crashlytics.h>
#import "BLJStoreManager.h"
#import "BLJStore.h"
#import "JBarStore.h"
#import "JCurrentProgramStore.h"
#import "JLiftStore.h"
#import "JPlateStore.h"
#import "JSetLogStore.h"
#import "JSetStore.h"
#import "JSettingsStore.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutStore.h"
#import "JFTOLiftStore.h"
#import "JFTOAssistanceStore.h"
#import "JFTOBoringButBigStore.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOSetStore.h"
#import "JFTOSettingsStore.h"
#import "JFTOSSTLiftStore.h"
#import "JFTOTriumvirateLiftStore.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOVariantStore.h"
#import "JFTOWorkoutStore.h"
#import "JSSLiftStore.h"
#import "JSSStateStore.h"
#import "JSSVariantStore.h"
#import "JSSWorkoutStore.h"
#import "JSJLiftStore.h"
#import "JSJWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "JVersionStore.h"
#import "JFTOBoringButBigLiftStore.h"
#import "JTimerStore.h"
#import "DataLoaded.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JSVWorkoutStore.h"
#import "JSVLiftStore.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOFullCustomWorkoutStore.h"
#import "JFTOFullCustomWeekStore.h"

@implementation BLJStoreManager

NSString *UPDATED_KEY = @"updateDate";

- (void)loadStores {
    id mostRecentlyUpdatedStore = [self mostRecentlyUpdatedStore];
    for (BLJStore *store in self.allStores) {
        if (store != [JVersionStore instance]) {
            CLS_LOG(@"Loading %@", NSStringFromClass([store modelClass]));
            [store load: mostRecentlyUpdatedStore];
        }
    }
    [[DataLoaded instance] setLoaded:YES];
}

- (id)mostRecentlyUpdatedStore {
    NSDate *date1 = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:UPDATED_KEY];
    NSDate *date2 = [[NSUserDefaults standardUserDefaults] objectForKey:UPDATED_KEY];
    if (date1 == nil && date2 == nil) {
        NSLog(@"TODO: HANDLE EXISTING APP STORE SELECITON");
    }
    else if (date1 == nil) {
        return [NSUserDefaults standardUserDefaults];
    }
    else {
        return [NSUbiquitousKeyValueStore defaultStore];
    }
}

- (void)syncStores {
    if (self.savingStores) {
        return;
    }

    self.savingStores = YES;
    @synchronized (self) {
        if ([[DataLoaded instance] loaded]) {
            [self clearSyncCache];
            [self testSerializeForErrors];
            [self writeStores];
        }
        self.savingStores = NO;
    }
}

- (void)clearSyncCache {
    for (BLJStore *store in self.allStores) {
        [store clearSyncCache];
    }
}

- (void)testSerializeForErrors {
    for (BLJStore *store in self.allStores) {
        [store serializeAndCache]; //any exceptions will get logged in crashlytics and prevent stores from being saved inconsistently
    }
}

- (void)writeStores {
    for (BLJStore *store in self.allStores) {
        [store sync];
    }

    [[NSUbiquitousKeyValueStore defaultStore] setObject:[NSDate new] forKey:UPDATED_KEY];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:UPDATED_KEY];
}

- (void)resetAllStores {
    for (BLJStore *store in self.allStores) {
        [store empty];
        [store sync];
    }

    for (BLJStore *store in self.allStores) {
        [store setupDefaults];
    }
}

- (void)resetAllStoresExceptLog {
    NSMutableArray *stores = [@[] mutableCopy];
    [stores addObjectsFromArray:self.allStores];
    [stores removeObject:[JWorkoutLogStore instance]];
    [stores removeObject:[JSetLogStore instance]];

    for (BLJStore *store in stores) {
        [store empty];
        [store sync];
    }

    for (BLJStore *store in stores) {
        [store setupDefaults];
    }

    [[JSetLogStore instance] load:nil];
    [[JWorkoutLogStore instance] load:nil];
}

+ (BLJStoreManager *)instance {
    static BLJStoreManager *manager = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        manager = [BLJStoreManager new];
        manager.allStores = @[
                [JVersionStore instance],

                [JSetLogStore instance],
                [JWorkoutLogStore instance],

                [JCurrentProgramStore instance],
                [JTimerStore instance],

                [JSettingsStore instance],
                [JFTOSettingsStore instance],

                [JBarStore instance],
                [JPlateStore instance],

                [JLiftStore instance],
                [JSSLiftStore instance],
                [JSJLiftStore instance],
                [JFTOLiftStore instance],
                [JSVLiftStore instance],

                [JFTOBoringButBigLiftStore instance],
                [JFTOTriumvirateLiftStore instance],
                [JFTOSSTLiftStore instance],
                [JFTOCustomAssistanceLiftStore instance],

                [JSetStore instance],
                [JFTOSetStore instance],
                [JWorkoutStore instance],

                [JFTOVariantStore instance],
                [JSSVariantStore instance],

                [JFTOAssistanceStore instance],
                [JFTOBoringButBigStore instance],
                [JFTOCustomWorkoutStore instance],

                [JFTOFullCustomWorkoutStore instance],
                [JFTOFullCustomWeekStore instance],

                [JFTOTriumvirateStore instance],

                [JFTOWorkoutStore instance],
                [JFTOCustomAssistanceWorkoutStore instance],
                [JFTOFullCustomAssistanceWorkoutStore instance],

                [JSJWorkoutStore instance],
                [JSVWorkoutStore instance],

                [JSSWorkoutStore instance],
                [JSSStateStore instance]
        ];
    });

    return manager;
}

- (BLJStore *)storeForModel:(Class)pClass withUuid:(NSString *)uuid {
    NSArray *matchingStores = [[self allStores] select:^(BLJStore *store) {
        return (BOOL) [[store modelClass] isSubclassOfClass:pClass];
    }];
    if ([matchingStores count] == 1) {
        return [matchingStores firstObject];
    }

    for (BLJStore *store in matchingStores) {
        if ([store find:@"uuid" value:uuid]) {
            return store;
        }
    }
    return nil;
}

- (id)findModelForClass:(Class)klass withUuid:(id)uuid {
    BLJStore *store = [self storeForModel:klass withUuid:uuid];
    return [store find:@"uuid" value:uuid];
}

@end
