#import "SKProductStore.h"
#import "NSArray+Enumerable.h"

@implementation SKProductStore

+ (instancetype)instance {
    static SKProductStore *store = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        store = [SKProductStore new];
    });

    return store;
}

- (void)loadProducts: (void(^)())callback {
    [[IAPAdapter instance] getProductsForIds:@[@"barLoading"] completion:^(NSArray *products) {
        self.products = products;
        if( callback ){
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