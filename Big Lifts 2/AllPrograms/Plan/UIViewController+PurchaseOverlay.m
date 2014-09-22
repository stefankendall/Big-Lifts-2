#import <MRCEnumerable/NSArray+Enumerable.h>
#import "UIViewController+PurchaseOverlay.h"
#import "PriceFormatter.h"
#import "PurchaseOverlay.h"
#import "BLColors.h"

@implementation UIViewController (PurchaseOverlay)

- (void)disableView:(UIView *)view {
    PurchaseOverlay *overlay = (PurchaseOverlay *) [view viewWithTag:kPurchaseOverlayTag];
    if (!overlay) {
        CGRect frame = CGRectMake(0, 0, [view frame].size.width, [view frame].size.height);

        [self addOverlayInFrameView:view frame:frame];

        if ([view respondsToSelector:@selector(setSelectionStyle:)]) {
            UITableViewCell *cell = (UITableViewCell *) view;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    }
}

- (void)addOverlayInFrameView:(UIView *)view frame:(CGRect)frame {
    PurchaseOverlay *overlay = [[NSBundle mainBundle] loadNibNamed:@"PurchaseOverlay" owner:self options:nil][0];
    overlay.backgroundColor = [[BLColors linkColor] colorWithAlphaComponent:.65];
    [overlay setFrame:frame];
    [view addSubview:overlay];
}

- (void)disableFullScreen:(NSString *)purchaseId view:(UIView *)view {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect frame = CGRectMake(0, 0, screenRect.size.width,
            screenRect.size.height -
                    self.navigationController.navigationBar.frame.size.height -
                    [UIApplication sharedApplication].statusBarFrame.size.height);
    [self addOverlayInFrameView:view frame:frame];
}

- (void)disableFullScreen:(NSString *)purchaseId view:(UIView *)view withDescription:(NSString *)description {
    [self disableFullScreen:purchaseId view:view];
    [self changeOverlayDescription:view description:description];
}

- (void)disableView:(UIView *)view withDescription:(NSString *)description {
    [self disableView:view];
    [self changeOverlayDescription:view description:description];
}

- (void)changeOverlayDescription:(UIView *)view description:(NSString *)description {
    PurchaseOverlay *overlay = (PurchaseOverlay *) [view viewWithTag:kPurchaseOverlayTag];
    [overlay.descriptionLabel setHidden:NO];
    [overlay.descriptionLabel setText:description];
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
            [self disableView:[self iapCells][iapProduct]];
        }
    }];
}

- (NSDictionary *)iapCells {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end