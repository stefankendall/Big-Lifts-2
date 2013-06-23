#import "StoreViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "StoreViewController.h"
#import "SKProductFake.h"
#import "CurrentProgramStore.h"
#import "CurrentProgram.h"

@implementation StoreViewControllerTests

- (void)testBarLoadingIsPurchased {
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    STAssertTrue([controller.barLoadingBuyButton isHidden], @"");
    STAssertFalse([controller.barLoadingPurchasedButton isHidden], @"");
}

- (void)testBarLoadingNotPurchased {
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    STAssertFalse([controller.barLoadingBuyButton isHidden], @"");
    STAssertTrue([controller.barLoadingPurchasedButton isHidden], @"");
}

- (void)testPriceOfFormatsPrice {
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    SKProductFake *product = [SKProductFake new];
    product.price = [[NSDecimalNumber alloc] initWithString:@"1.99"];
    product.priceLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    STAssertEqualObjects([controller priceOf:product], @"$1.99", @"");
}

- (void)testPurchaseIdForButtonBarLoading {
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    NSString *purchaseId = [controller purchaseIdForButton:controller.barLoadingBuyButton];
    STAssertEqualObjects(purchaseId, @"barLoading", @"");
}

- (void)testPurchaseIdForButtonOnus {
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    NSString *purchaseId = [controller purchaseIdForButton:controller.onusWunslerBuyButton];
    STAssertEqualObjects(purchaseId, @"ssOnusWunsler", @"");
}

- (void) testSectionShouldBeVisibleStartingStrength {
    CurrentProgram *program = [[CurrentProgramStore instance] create];
    program.name = @"StartingStrength";
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    STAssertTrue([controller sectionShouldBeVisible: 0], @"");
    STAssertTrue([controller sectionShouldBeVisible: 1], @"");
    STAssertFalse([controller sectionShouldBeVisible: 2], @"");
}

- (void) testSectionShouldBeVisible531 {
    CurrentProgram *program = [[CurrentProgramStore instance] create];
    program.name = @"5/3/1";
    StoreViewController *controller = [self getControllerByStoryboardIdentifier:@"storeViewController"];
    STAssertTrue([controller sectionShouldBeVisible: 0], @"");
    STAssertFalse([controller sectionShouldBeVisible: 1], @"");
    STAssertTrue([controller sectionShouldBeVisible: 2], @"");
}

@end