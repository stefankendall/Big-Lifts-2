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

@implementation BLJStoreManager

- (void)loadStores {
    for(BLJStore *store in self.allStores){
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
                [JFTOLiftStore instance]
        ];
    }

    return manager;
}

@end