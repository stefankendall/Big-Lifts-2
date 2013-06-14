#import "StoreViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "StoreViewController.h"
#import "IAPManager.h"
#import "IAPAdapter.h"

@implementation StoreViewControllerTests

- (void) setUp {
    [[IAPAdapter instance] resetPurchases];
}

- (void) testBarLoadingIsPurchased {
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    STAssertTrue([controller.barLoadingBuyButton isHidden], @"");
    STAssertFalse([controller.barLoadingPurchasedButton isHidden], @"");
}

- (void) testBarLoadingNotPurchased {
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    STAssertFalse([controller.barLoadingBuyButton isHidden], @"");
    STAssertTrue([controller.barLoadingPurchasedButton isHidden], @"");
}

@end