#import "UpSellViewController.h"
#import "Purchaser.h"
#import "PriceFormatter.h"
#import "SKProductStore.h"

@implementation UpSellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Did you know?";

    NSString *productId = [self everythingProductId];
    SKProduct *product = [[SKProductStore instance] productById:productId];
    if (product) {
        [self.buyButton setTitle:[NSString stringWithFormat:@"Unlock! (%@)", [[PriceFormatter new] priceOf:product]]
                        forState:UIControlStateNormal];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(somethingPurchased)
                                                 name:IAP_PURCHASED_NOTIFICATION
                                               object:nil];
}

- (void)somethingPurchased {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buyButtonTapped:(id)sender {
    [[Purchaser new] purchase:[self everythingProductId]];
}

- (NSString *const)everythingProductId {
    return [Purchaser hasPurchasedAnything] ? IAP_EVERYTHING_DISCOUNT : IAP_EVERYTHING;
}

@end