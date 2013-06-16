#import "StoreViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "StoreViewController.h"
#import "SKProductFake.h"

@implementation StoreViewControllerTests

- (void)setUp {
    [[IAPAdapter instance] resetPurchases];
}

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

@end