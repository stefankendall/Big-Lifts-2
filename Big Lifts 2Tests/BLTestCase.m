#import "BLTestCase.h"
#import "BLStoreManager.h"
#import "IAPAdapter.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"

@implementation BLTestCase

- (void)setUp {
    [[SKProductStore instance] removePurchases];
    [[IAPAdapter instance] resetPurchases];
    [[BLJStoreManager instance] resetAllStores];
}

@end