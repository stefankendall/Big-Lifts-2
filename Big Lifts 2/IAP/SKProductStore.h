#import "IAPAdapter.h"

@interface SKProductStore : NSObject

+ (instancetype)instance;

- (void)removePurchases;

- (SKProduct *)productById:(NSString *)productId;

- (void)loadProducts:(void (^)())callback;

@property(nonatomic, strong) NSArray *products;
@property(nonatomic, strong) NSArray *allPurchaseIds;

@end