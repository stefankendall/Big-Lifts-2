#import "LikeViewController.h"
#import "FBAppCall.h"
#import "FBDialogs.h"
#import "Purchaser.h"
#import "IAPAdapter.h"
#import "PriceFormatter.h"
#import "SKProductStore.h"

@implementation LikeViewController

- (void)viewDidLoad {
    [self addPriceToCostLabel];
}

- (void)addPriceToCostLabel {
    SKProduct *product = [[SKProductStore instance] productById:IAP_SPONSORSHIP];
    NSString *priceText = [[PriceFormatter new] priceOf:product];
    priceText = priceText == nil ? @"error" : priceText;
    NSString *costText = [self.costParagraphLabel text];
    [self.costParagraphLabel setText:
            [costText stringByReplacingOccurrencesOfString:@"{cost}" withString:priceText]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell viewWithTag:1]) {
        [self shareOnFacebook];
    }
}

- (void)shareOnFacebook {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/big-lifts-pro/id534996988?mt=8"];
    [FBDialogs presentShareDialogWithLink:url
                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                      if (error) {
                                          NSLog(@"Error: %@", error.description);
                                      } else {
                                          NSLog(@"Neither of these get hit. Figure this out later.");
                                      }
                                  }];
}

- (IBAction)buySponsorship:(id)sender {
    [[Purchaser new] purchase:IAP_SPONSORSHIP];
}

@end