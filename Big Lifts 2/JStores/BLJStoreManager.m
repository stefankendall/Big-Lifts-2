#import "BLJStoreManager.h"
#import "BLJStore.h"

@implementation BLJStoreManager

- (void)loadStores {
    self.allStores = @[
    ];
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
    }

    return manager;
}

@end