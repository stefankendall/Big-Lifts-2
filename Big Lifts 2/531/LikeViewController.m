#import "LikeViewController.h"
#import "FBAppCall.h"
#import "FBDialogs.h"
#import "Purchaser.h"

@implementation LikeViewController

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