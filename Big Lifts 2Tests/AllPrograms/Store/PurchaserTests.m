#import "PurchaserTests.h"
#import "Purchaser.h"
#import "IAPAdapter.h"

@implementation PurchaserTests

- (void)testHasPurchasedAnything {
    [[IAPAdapter instance] addPurchase:IAP_FTO_CUSTOM];
    STAssertTrue([[Purchaser new] hasPurchasedAnything], @"");
}

- (void)testHasPurchasedAnythingNoPurchases {
    STAssertFalse([[Purchaser new] hasPurchasedAnything], @"");
}

@end