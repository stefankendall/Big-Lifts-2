#import <Foundation/Foundation.h>

@interface UITableViewController (PurchaseOverlay)
- (void)disable:(NSString *)purchaseId cell:(UITableViewCell *)cell;
- (void)enable :(UITableViewCell *)cell;
@end