#import "SSBarLoadingViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSBarLoadingViewController.h"
#import "IAPAdapter.h"
#import "PurchaseOverlay.h"

@implementation SSBarLoadingViewControllerTests

- (void)testAddsDisableViewIfUnpurchased {
    SSBarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertNotNil(controller.overlay, @"");
}

- (void)testNoDisableViewIfPurchased {
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    SSBarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertNil(controller.overlay, @"");
}

- (void)testDisableViewIsRemovedAfterPurchase {
    SSBarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    [controller viewWillAppear:YES];
    STAssertNil(controller.overlay, @"");
}

@end