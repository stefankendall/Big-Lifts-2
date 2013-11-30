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

@implementation BLJStoreManager

- (void)loadStores {
    for (BLJStore *store in self.allStores) {
        [store load];
    }
}

- (void)syncStores {
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

+ (BLJStoreManager *)instance {
    static BLJStoreManager *manager = nil;

    if (!manager) {
        manager = [BLJStoreManager new];
        manager.allStores = @[
                [JSettingsStore instance],
                [JFTOSettingsStore instance],
                [JBarStore instance],
                [JPlateStore instance],
                [JCurrentProgramStore instance],

                [JLiftStore instance],
                [JSJLiftStore instance],
                [JFTOLiftStore instance],
                [JFTOTriumvirateLiftStore instance],
                [JFTOSSTLiftStore instance],
                [JSSLiftStore instance],
                [JSetStore instance],

                [JSetLogStore instance],
                [JWorkoutLogStore instance],

                [JWorkoutStore instance],
                [JFTOVariantStore instance],
                [JFTOAssistanceStore instance],
                [JFTOBoringButBigStore instance],
                [JFTOCustomWorkoutStore instance],
                [JFTOSetStore instance],
                [JFTOTriumvirateStore instance],
                [JFTOWorkoutStore instance],
                [JSSVariantStore instance],
                [JSSWorkoutStore instance],
                [JSSStateStore instance],
                [JSJWorkoutStore instance]
        ];
    }

    return manager;
}

- (BLJStore *)storeForModel:(Class)pClass withUuid:(NSString *)uuid {
    NSArray *matchingStores = [[self allStores] select:^(BLJStore *store) {
        return (BOOL) [[store modelClass] isSubclassOfClass: pClass];
    }];
    if([matchingStores count] == 1){
        return [matchingStores firstObject];
    }

    for (BLJStore *store in matchingStores) {
        if([store find:@"uuid" value:uuid]){
            return store;
        }
    }
    return nil;

}

@end