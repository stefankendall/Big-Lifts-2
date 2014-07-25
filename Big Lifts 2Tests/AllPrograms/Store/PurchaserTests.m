#import "PurchaserTests.h"
#import "Purchaser.h"
#import "IAPAdapter.h"

@implementation PurchaserTests

- (void)testHasPurchasedAnything {
    [[IAPAdapter instance] addPurchase:IAP_FTO_CUSTOM];
    STAssertTrue([Purchaser hasPurchasedAnything], @"");
}

- (void)testHasPurchasedAnythingNoPurchases {
    STAssertFalse([Purchaser hasPurchasedAnything], @"");
}

@end