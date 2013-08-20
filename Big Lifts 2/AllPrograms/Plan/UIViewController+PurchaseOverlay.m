#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "UIViewController+PurchaseOverlay.h"
#import "PriceFormatter.h"
#import "SKProductStore.h"
#import "PurchaseOverlay.h"
#import "Purchaser.h"

@implementation UIViewController (PurchaseOverlay)

- (void)disable:(NSString *)purchaseId view:(UIView *)view {
    if (![view viewWithTag:kPurchaseOverlayTag]) {
        PurchaseOverlay *overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
        CGRect frame = CGRectMake(0, 0, [view frame].size.width, [view frame].size.height);
        [overlay setFrame:frame];
        SKProduct *product = [[SKProductStore instance] productById:purchaseId];
        [overlay.price setText:[[PriceFormatter new] priceOf:product]];
        [view addSubview:overlay];
        if ([view respondsToSelector:@selector(setSelectionStyle:)]) {
            UITableViewCell *cell = (UITableViewCell *) view;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    }
}

- (void)enable :(UIView *)view {
    if ([view viewWithTag:kPurchaseOverlayTag]) {
        UIView *overlay = [view viewWithTag:kPurchaseOverlayTag];
        [overlay removeFromSuperview];
        if ([view respondsToSelector:@selector(setSelectionStyle:)]) {
            UITableViewCell *cell = (UITableViewCell *) view;
            [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        }
    }
}

- (void)enableDisableIapCells {
    [[[self iapCells] allKeys] each:^(NSString *iapProduct) {
        if ([[IAPAdapter instance] hasPurchased:iapProduct]) {
            [self enable:[self iapCells][iapProduct]];
        }
        else {
            [self disable:iapProduct view:[self iapCells][iapProduct]];
        }
    }];
}

- (NSDictionary *) iapCells {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)purchaseFromCell:(UITableViewCell *)selectedCell {
    NSString *purchaseId = [[self iapCells] detect:^BOOL(id key, id obj) {
        return selectedCell == obj;
    }];
    [[Purchaser new] purchase:purchaseId];
}

@end