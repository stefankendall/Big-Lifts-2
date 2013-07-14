#import "PriceFormatterTests.h"
#import "SKProductFake.h"
#import "PriceFormatter.h"

@implementation PriceFormatterTests

- (void)testPriceOfFormatsPrice {
    PriceFormatter *formatter = [PriceFormatter new];
    SKProductFake *product = [SKProductFake new];
    product.price = [[NSDecimalNumber alloc] initWithString:@"1.99"];
    product.priceLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    STAssertEqualObjects([formatter priceOf:product], @"$1.99", @"");
}

@end