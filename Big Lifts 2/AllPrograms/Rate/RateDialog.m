#import "RateDialog.h"
#import "DataLoaded.h"

@implementation RateDialog
//
//- (void)show {
//    if (![self hasSeenDialog] && ![[DataLoaded instance] firstTimeInApp]) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                initWithTitle:@"Help the app?"
//                      message:@"Like the app and have a second to rate it?"
//                     delegate:self
//            cancelButtonTitle:nil
//            otherButtonTitles:nil];
//        self.noButtonIndex = [alert addButtonWithTitle:@"No."];
//        self.yesButtonIndex = [alert addButtonWithTitle:@"Sure!"];
//        [alert show];
//    }
//}
//
//- (BOOL)hasSeenDialog {
//    return [[BLKeyValueStore store] boolForKey:@"rate1"];
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == self.yesButtonIndex) {
//        NSString *rateUrl = @"itms-apps://itunes.apple.com/app/id661503150";
//        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:rateUrl]];
//    }
//    [[BLKeyValueStore store] setBool:YES forKey:@"rate1"];
//}

@end