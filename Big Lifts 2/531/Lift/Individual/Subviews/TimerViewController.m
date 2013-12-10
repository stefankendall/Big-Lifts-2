#import "TimerViewController.h"
#import "PaddingTextField.h"
#import "TimerProtocol.h"
#import "BLTimer.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation TimerViewController

- (void)viewDidLoad {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.restMinutes];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.restSeconds];
}

- (IBAction) timerTapped:(id) sender {
    [self startTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startTimer {
    int minutes = [[self.restMinutes text] intValue];
    int seconds = [[self.restSeconds text] intValue];
    int totalSeconds = minutes * 60 + seconds;
    [[BLTimer instance] start: totalSeconds];
}

@end