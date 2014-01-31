#import "RestToolbar.h"
#import "BLTimer.h"

@implementation RestToolbar

- (void)updateTime {
    if ([[BLTimer instance] isRunning]) {
        [self.timerButton setTitle:[[BLTimer instance] formattedTimeRemaining] forState:UIControlStateNormal];
    }
    else {
        [self.timerButton setTitle:@"Timer" forState:UIControlStateNormal];
    }
}

@end