#import <MRCEnumerable/NSArray+Enumerable.h>
#import <MRCEnumerable/NSDictionary+Enumerable.h>
#import "UIViewController+PurchaseOverlay.h"
#import "PriceFormatter.h"
#import "SKProductStore.h"
#import "PurchaseOverlay.h"
#import "Purchaser.h"
#import "BLColors.h"

@implementation UIViewController (PurchaseOverlay)

- (void)disable:(NSString *)purchaseId view:(UIView *)view {
    PurchaseOverlay *overlay = (PurchaseOverlay *) [view viewWithTag:kPurchaseOverlayTag];
    if (!overlay) {
        CGRect frame = CGRectMake(0, 0, [view frame].size.width, [view frame].size.height);

        [self addOverlayInFrame:purchaseId view:view frame:frame];

        if ([view respondsToSelector:@selector(setSelectionStyle:)]) {
            UITableViewCell *cell = (UITableViewCell *) view;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    }
    else {
        [overlay setLoading:NO];
    }
}

- (void)addOverlayInFrame:(NSString *)purchaseId view:(UIView *)view frame:(CGRect)frame {
    PurchaseOverlay *overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
    overlay.backgroundColor = [[BLColors linkColor] colorWithAlphaComponent:.65];
    [overlay setFrame:frame];
    SKProduct *product = [[SKProductStore instance] productById:purchaseId];
    if (product) {
        [overlay.price setText:[[PriceFormatter new] priceOf:product]];
    }
    else {
        [overlay.price setText:@"Can't connect to app store"];
    }

    [view addSubview:overlay];
}

- (void)disableFullScreen:(NSString *)purchaseId view:(UIView *)view {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, 0, screenRect.size.width,
            screenRect.size.height -
                    self.navigationController.navigationBar.frame.size.height -
                    [UIApplication sharedApplication].statusBarFrame.size.height);
    [self addOverlayInFrame:purchaseId view:view frame:frame];
}

- (void)disableFullScreen:(NSString *)purchaseId view:(UIView *)view withDescription:(NSString *)description {
    [self disableFullScreen:purchaseId view:view];
    [self changeOverlayDescription:view description:description];
}

- (void)disable:(NSString *)purchaseId view:(UIView *)view withDescription:(NSString *)description {
    [self disable:purchaseId view:view];
    [self changeOverlayDescription:view description:description];
}

- (void)changeOverlayDescription:(UIView *)view description:(NSString *)description {
    PurchaseOverlay *overlay = (PurchaseOverlay *) [view viewWithTag:kPurchaseOverlayTag];
    [overlay.description setHidden:NO];
    [overlay.description setText:description];
}

- (void)enable:(UIView *)view {
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

- (NSDictionary *)iapCells {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)purchaseFromCell:(UITableViewCell *)selectedCell {
    NSString *purchaseId = [[self iapCells] detect:^BOOL(id key, id obj) {
        return selectedCell == obj;
    }];
    PurchaseOverlay *overlay = (PurchaseOverlay *) [selectedCell viewWithTag:kPurchaseOverlayTag];
    [overlay setLoading:YES];
    [[Purchaser new] purchase:purchaseId];
}

@end