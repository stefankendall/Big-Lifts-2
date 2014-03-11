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
                IAP_GRAPHING,
                IAP_1RM,
                IAP_SS_WARMUP,
                IAP_SS_ONUS_WUNSLER,
                IAP_SS_PRACTICAL_PROGRAMMING,
                IAP_FTO_JOKER,
                IAP_FTO_ADVANCED,
                IAP_FTO_TRIUMVIRATE,
                IAP_FTO_SST,
                IAP_FTO_FIVES_PROGRESSION,
                IAP_FTO_CUSTOM,
                IAP_FTO_FULL_CUSTOM_ASSISTANCE
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
        [self recordPurchases];
    }];
}

- (void)recordPurchases {
    [self.allPurchaseIds each:^(NSString *productId) {
        if ([[IAPAdapter instance] hasPurchased:productId]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productId];
        }
    }];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removePurchases {
    [self.allPurchaseIds each:^(NSString *productId) {
        if ([[IAPAdapter instance] hasPurchased:productId]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:productId];
        }
    }];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (SKProduct *)productById:(NSString *)productId {
    return [self.products detect:^BOOL(SKProduct *product) {
        return [product.productIdentifier isEqualToString:productId];
    }];
}

@end