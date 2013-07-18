#import "UITableViewController+PurchaseOverlay.h"
#import "PriceFormatter.h"
#import "SKProductStore.h"
#import "PurchaseOverlay.h"

@implementation UITableViewController (PurchaseOverlay)

- (void)disable:(NSString *)purchaseId cell:(id)cell {
    if (![cell viewWithTag:kPurchaseOverlayTag]) {
        PurchaseOverlay *overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
        CGRect frame = CGRectMake(0, 0, [cell frame].size.width, [cell frame].size.height);
        [overlay setFrame:frame];
        SKProduct *product = [[SKProductStore instance] productById:purchaseId];
        [overlay.price setText:[[PriceFormatter new] priceOf:product]];
        [cell addSubview:overlay];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}

- (void)enable :(UITableViewCell *)cell {
    if ([cell viewWithTag:kPurchaseOverlayTag]) {
        UIView *overlay = [cell viewWithTag:kPurchaseOverlayTag];
        [overlay removeFromSuperview];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
}

@end