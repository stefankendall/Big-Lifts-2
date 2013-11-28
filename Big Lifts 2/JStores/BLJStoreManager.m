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

@implementation BLJStoreManager

- (void)loadStores {
    for (BLJStore *store in self.allStores) {
        [store load];
    }
}

- (void)resetAllStores {
    for (BLJStore *store in self.allStores) {
        [store empty];
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
                [JBarStore instance],
                [JCurrentProgramStore instance],
                [JLiftStore instance],
                [JPlateStore instance],
                [JSetLogStore instance],
                [JSetStore instance],
                [JWorkoutLogStore instance],
                [JWorkoutStore instance],
                [JFTOSettingsStore instance],
                [JFTOVariantStore instance],
                [JFTOAssistanceStore instance],
                [JFTOBoringButBigStore instance],
                [JFTOCustomWorkoutStore instance],
                [JFTOLiftStore instance],
                [JFTOSetStore instance],
                [JFTOSSTLiftStore instance],
                [JFTOTriumvirateLiftStore instance],
                [JFTOTriumvirateStore instance],
                [JFTOWorkoutStore instance],
                [JSSStateStore instance],
                [JSSLiftStore instance],
                [JSSVariantStore instance],
                [JSSWorkoutStore instance],
                [JSJLiftStore instance],
                [JSJWorkoutStore instance]
        ];
    }

    return manager;
}

@end