#import "LikeViewController.h"
#import "FBAppCall.h"
#import "FBDialogs.h"

@implementation LikeViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell viewWithTag:1]) {
        [self shareOnFacebook];
    } else if ([cell viewWithTag:2]) {
        [self followOnTwitter];
    }
    else if ([cell viewWithTag:3]) {
        [self rateApp];
    }
}

- (void)followOnTwitter {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=BigLiftsApp"]];
    }
}

- (void)shareOnFacebook {
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/big-lifts-2/id661503150?mt=8"];
    [FBDialogs presentShareDialogWithLink:url
                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                      if (error) {
                                          NSLog(@"Error: %@", error.description);
                                      } else {
                                          NSLog(@"Neither of these get hit. Figure this out later.");
                                      }
                                  }];
}

- (void)rateApp {
    NSString *rateUrl = @"itms-apps://itunes.apple.com/app/id661503150";
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:rateUrl]];
}

@end