#import <Foundation/Foundation.h>

@interface UIViewController (PurchaseOverlay)
- (void)disable:(NSString *)purchaseId view:(UIView *)view;

- (void)disable:(NSString *)purchaseId view:(UIView *)view withDescription:(NSString *)description;

- (void)disableFullScreen:(NSString *)purchaseId view:(UIView *)view withDescription:(NSString *)description;

- (void)enable:(UIView *)view;

- (void)enableDisableIapCells;

- (void)purchaseFromCell:(UITableViewCell *)selectedCell;
@end