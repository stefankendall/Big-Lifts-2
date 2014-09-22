#import <Foundation/Foundation.h>

@interface UIViewController (PurchaseOverlay)
- (void)disableView:(UIView *)view;

- (void)disableView:(UIView *)view withDescription:(NSString *)description;

- (void)disableFullScreen:(NSString *)purchaseId view:(UIView *)view withDescription:(NSString *)description;

- (void)enable:(UIView *)view;

- (void)enableDisableIapCells;

@end