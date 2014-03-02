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
#import "BLKeyValueStore.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"

@implementation BLJStoreManager

- (void)loadStores {
    for (BLJStore *store in self.allStores) {
        if ([[DataLoaded instance] timedOut]) {
            return;
        }

        if (store != [JVersionStore instance]) {
            @try {
                CLS_LOG(@"Loading %@", NSStringFromClass([store modelClass]));
                [store load];
            }
            @catch (NSException *e) {
                [store empty];
                [store sync];
                [store setupDefaults];
            }
        }
    }
    [[DataLoaded instance] setLoaded:YES];
}

- (void)syncStores {
    [self writeStores];
    [[BLKeyValueStore store] synchronize];
}

- (void)writeStores {
    for (BLJStore *store in self.allStores) {
        [store sync];
    }
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

                [JSetLogStore instance],
                [JWorkoutLogStore instance],

                [JFTOVariantStore instance],
                [JSSVariantStore instance],
                [JSSStateStore instance],

                [JFTOAssistanceStore instance],
                [JFTOBoringButBigStore instance],
                [JFTOCustomWorkoutStore instance],
                [JFTOTriumvirateStore instance],
                [JFTOCustomAssistanceWorkoutStore instance],
                [JFTOFullCustomAssistanceWorkoutStore instance],

                [JFTOWorkoutStore instance],
                [JSSWorkoutStore instance],
                [JSJWorkoutStore instance],
                [JSVWorkoutStore instance]
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
