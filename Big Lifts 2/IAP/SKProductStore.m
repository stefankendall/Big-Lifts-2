#import "SKProductStore.h"
#import "NSArray+Enumerable.h"
#import "Purchaser.h"

@implementation SKProductStore

+ (instancetype)instance {
    static SKProductStore *store = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        store = [SKProductStore new];
        store.allPurchaseIds = @[
                IAP_BAR_LOADING,
                IAP_SS_ONUS_WUNSLER,
                IAP_SS_WARMUP,
                IAP_SS_PRACTICAL_PROGRAMMING,
                FTO_JOKER
        ];
    });

    return store;
}

- (void)loadProducts:(void (^)())callback {
    [[IAPAdapter instance] getProductsForIds:self.allPurchaseIds completion:^(NSArray *products) {
        self.products = products;
        if (callback) {
            callback();
        }
    }];
}

- (SKProduct *)productById:(NSString *)productId {
    return [self.products detect:^BOOL(SKProduct *product) {
        return [product.productIdentifier isEqualToString:productId];
    }];
}

- (BOOL)hasLoaded {
    return self.products == nil;
}

@end