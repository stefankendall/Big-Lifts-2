#import <Foundation/Foundation.h>

@interface UIViewController (PurchaseOverlay)
- (void)disable:(NSString *)purchaseId view:(UIView *)view;

- (void)enable :(UIView *)view;

- (void)enableDisableIapCells;
@end