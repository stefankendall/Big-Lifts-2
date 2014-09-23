#import "IAPAdapter.h"
#import "JSettings.h"
#import "Purchaser.h"

@implementation IAPAdapter

+ (IAPAdapter *)instance {
    static IAPAdapter *instance;
    if (instance == nil) instance = [IAPAdapter new];
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.testPurchases = [@[] mutableCopy];
    }

    return self;
}

- (BOOL)hasPurchased:(NSString *)productId {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:productId]
            || [[NSUserDefaults standardUserDefaults] boolForKey:IAP_EVERYTHING]
            || [[NSUserDefaults standardUserDefaults] boolForKey:IAP_EVERYTHING_DISCOUNT]) {
        return YES;
    }


    if ([self.testPurchases count] == 0) {
        return [super hasPurchased:IAP_EVERYTHING] || [super hasPurchased:IAP_EVERYTHING_DISCOUNT] || [super hasPurchased:productId];
    }
    else {
        return [self.testPurchases containsObject:IAP_EVERYTHING]
                || [self.testPurchases containsObject:IAP_EVERYTHING_DISCOUNT]
                || [self.testPurchases containsObject:productId];
    }
}

- (void)addPurchase:(NSString *)productId {
    [self.testPurchases addObject:productId];
}

- (void)resetPurchases {
    self.testPurchases = [@[] mutableCopy];
}

- (void)purchaseProductForId:(NSString *)productId completion:(PurchaseCompletionBlock)completionBlock error:(ErrorBlock)err {
#if (TARGET_IPHONE_SIMULATOR)
    [self addPurchase: productId];
    __block PurchaseCompletionBlock purchaseCompletionBlock = completionBlock;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        purchaseCompletionBlock(NULL);
    });
#else
    [super purchaseProductForId:productId completion:completionBlock error:err];
#endif
}

@end