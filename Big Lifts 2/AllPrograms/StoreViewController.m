#import "StoreViewController.h"
#import "IAPAdapter.h"

@implementation StoreViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideShowBarLoadingBuyButton];
}

- (void)hideShowBarLoadingBuyButton {
    BOOL barLoadingPurchased = [[IAPAdapter instance] hasPurchased:@"barLoading"];
    [self.barLoadingBuyButton setHidden:barLoadingPurchased];
    [self.barLoadingPurchasedButton setHidden:!barLoadingPurchased];
}

- (IBAction)buyBarLoadingButtonTapped:(id)sender {
    [[IAPAdapter instance] purchaseProductForId:@"barLoading" completion:^(NSObject *_){
        UIAlertView *thanks = [[UIAlertView alloc] initWithTitle:@"Purchased!"
                                                         message:@"Bar loading is now available throughout the app."
                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [thanks performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        [self hideShowBarLoadingBuyButton];
    }                                     error:^(NSError *err) {
        NSLog(@"%@", [err localizedDescription]);
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Could not purchase..."
                                                        message:@"Something went wrong trying to connect to the store. Please try again later."
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [error performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }];
}
@end