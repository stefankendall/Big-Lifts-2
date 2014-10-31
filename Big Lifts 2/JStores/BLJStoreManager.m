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
            [store load:mostRecentlyUpdatedStore];
        }
    }
    [[DataLoaded instance] setLoaded:YES];
}

- (id)mostRecentlyUpdatedStore {
    NSDate *cloudDate = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:UPDATED_KEY];
    NSDate *localDate = [[NSUserDefaults standardUserDefaults] objectForKey:UPDATED_KEY];
    if (cloudDate == nil && localDate == nil) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"useIcloud"] == nil) {
            return [NSUbiquitousKeyValueStore defaultStore];
        }
        BOOL useIcloud = [[NSUserDefaults standardUserDefaults] boolForKey:@"useIcloud"];
        return useIcloud ? [NSUbiquitousKeyValueStore defaultStore] : [NSUserDefaults standardUserDefaults];
    }
    else if (cloudDate == nil) {
        return [NSUserDefaults standardUserDefaults];
    }
    else if (localDate == nil) {
        return [NSUbiquitousKeyValueStore defaultStore];
    }
    else {
        if ([cloudDate compare:localDate] == NSOrderedDescending) {
            return [NSUbiquitousKeyValueStore defaultStore];
        }
        else {
            return [NSUserDefaults standardUserDefaults];
        }
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
