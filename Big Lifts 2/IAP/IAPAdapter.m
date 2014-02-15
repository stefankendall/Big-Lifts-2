#import "IAPAdapter.h"
#import "JSettingsStore.h"
#import "JSettings.h"

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
    if ([[[JSettingsStore instance] first] adsEnabled]) {
        return YES;
    }

    if ([[NSUserDefaults standardUserDefaults] boolForKey:productId]) {
        return YES;
    }

    if ([self.testPurchases count] == 0) {
        return [super hasPurchased:productId];
    }
    else {
        return [self.testPurchases containsObject:productId];
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