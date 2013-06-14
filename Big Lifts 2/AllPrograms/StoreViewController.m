#import "StoreViewController.h"
#import "IAPAdapter.h"

@implementation StoreViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BOOL barLoadingPurchased = [[IAPAdapter instance] hasPurchased:@"barLoading"];
    [self.barLoadingBuyButton setHidden:barLoadingPurchased];
    [self.barLoadingPurchasedButton setHidden:!barLoadingPurchased];
}

@end