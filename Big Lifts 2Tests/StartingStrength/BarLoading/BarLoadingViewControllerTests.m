#import "BarLoadingViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "BarLoadingViewController.h"
#import "IAPAdapter.h"
#import "PurchaseOverlay.h"

@implementation BarLoadingViewControllerTests

- (void)testAddsDisableViewIfUnpurchased {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertNotNil([controller.view viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testNoDisableViewIfPurchased {
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    STAssertNil([controller.view viewWithTag:kPurchaseOverlayTag], @"");
}

- (void)testDisableViewIsRemovedAfterPurchase {
    BarLoadingViewController *controller = [self getControllerByStoryboardIdentifier:@"barLoading"];
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    [controller viewWillAppear:YES];
    STAssertNil([controller.view viewWithTag:kPurchaseOverlayTag], @"");
}

@end