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

@implementation BLJStoreManager

- (void)loadStores {
    for (BLJStore *store in self.allStores) {
        if (store != [JVersionStore instance]) {
            @try {
                [store load];
            }
            @catch (NSException *e) {
                //TODO: log with crashlytics when they update the library.
                [store empty];
                [store sync];
                [store setupDefaults];
            }
        }
    }
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"jstoresLoaded" object:nil]];
}

- (void)syncStores {
    for (BLJStore *store in self.allStores) {
        [store sync];
    }
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
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

                [JSettingsStore instance],
                [JFTOSettingsStore instance],
                [JBarStore instance],
                [JPlateStore instance],
                [JCurrentProgramStore instance],

                [JTimerStore instance],

                [JLiftStore instance],
                [JSJLiftStore instance],
                [JFTOLiftStore instance],

                [JFTOBoringButBigLiftStore instance],
                [JFTOTriumvirateLiftStore instance],
                [JFTOSSTLiftStore instance],
                [JSSLiftStore instance],

                [JSetStore instance],
                [JFTOSetStore instance],
                [JWorkoutStore instance],

                [JSetLogStore instance],
                [JWorkoutLogStore instance],

                [JFTOVariantStore instance],
                [JSSVariantStore instance],
                [JSSStateStore instance],

                [JFTOAssistanceStore instance],
                [JFTOBoringButBigStore instance],
                [JFTOCustomWorkoutStore instance],
                [JFTOTriumvirateStore instance],

                [JFTOWorkoutStore instance],
                [JSSWorkoutStore instance],
                [JSJWorkoutStore instance]
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

@end