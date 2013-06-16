#import "IAPAdapter.h"

@interface SKProductStore : NSObject

+ (instancetype)instance;

- (SKProduct *)productById:(NSString *)productId;

- (void)loadProducts;

@property(nonatomic, strong) NSArray *products;

@end