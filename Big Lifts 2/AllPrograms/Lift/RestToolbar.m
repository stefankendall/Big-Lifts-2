#import "RestToolbar.h"
#import "BLTimer.h"
#import "WorkoutSharer.h"
#import "ShareDelegate.h"

@implementation RestToolbar

- (void)awakeFromNib {
    [self.shareButton addTarget:self action:@selector(showShareSheet) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showShareSheet {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Twitter", @"Facebook", nil];
    [sheet showInView:self.shareDelegate.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        [[WorkoutSharer new] shareOnTwitter:[self.shareDelegate getSharedWorkout] withController:self.shareDelegate];
    }
    else if (buttonIndex == (actionSheet.firstOtherButtonIndex + 1)) {
        [[WorkoutSharer new] shareOnFacebook:[self.shareDelegate getSharedWorkout] withController:self.shareDelegate];
    }
}

- (void)updateTime {
    if ([[BLTimer instance] isRunning]) {
        [self.timerButton setTitle:[[BLTimer instance] formattedTimeRemaining] forState:UIControlStateNormal];
    }
    else {
        [self.timerButton setTitle:@"Timer" forState:UIControlStateNormal];
    }
}

@end