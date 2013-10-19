#import "PurchaseOverlay.h"

int kPurchaseOverlayTag = 10;

@implementation PurchaseOverlay

- (void)setLoading:(BOOL)loading {
    [self.price setHidden:loading];
    [self.buyImage setHidden:loading];
    [self.loadingIndicator setHidden:!loading];
}

@end