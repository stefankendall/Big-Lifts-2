#import "IAPAdapter.h"

@interface SKProductFake : SKProduct

@property(nonatomic) NSDecimalNumber *price;

@property(nonatomic) NSLocale *priceLocale;

@end