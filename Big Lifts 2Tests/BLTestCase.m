#import "BLTestCase.h"
#import "IAPAdapter.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"
#import "DataLoaded.h"

@implementation BLTestCase

- (void)setUp {
    [[SKProductStore instance] removePurchases];
    [[IAPAdapter instance] resetPurchases];
    [self waitForDataLoaded];
    [[BLJStoreManager instance] resetAllStores];
}

- (void)waitForDataLoaded {
    while (![[DataLoaded instance] loaded]) {
        [NSThread sleepForTimeInterval:0.1f];
    }
}

@end