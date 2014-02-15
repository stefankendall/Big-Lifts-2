#import "AdsOptInDialog.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation AdsOptInDialog

- (void)show {
    UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:@"You've been selected for a test!"
                  message:@"Would you like to unlock all in-app purchases by enabling ads? You can always opt-out in the Settings."
                 delegate:self
        cancelButtonTitle:nil
        otherButtonTitles:nil];
    self.noButtonIndex = [alert addButtonWithTitle:@"No"];
    self.yesButtonIndex = [alert addButtonWithTitle:@"Yes"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == self.yesButtonIndex) {
        [[[JSettingsStore instance] first] setAdsEnabled:YES];
    }
}

@end