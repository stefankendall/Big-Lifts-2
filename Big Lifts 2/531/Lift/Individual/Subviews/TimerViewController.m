#import "TimerViewController.h"
#import "PaddingTextField.h"
#import "BLTimer.h"
#import "TextViewInputAccessoryBuilder.h"
#import "JTimerStore.h"
#import "JTimer.h"

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.restMinutes];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.restSeconds];
}

- (void)viewWillAppear:(BOOL)animated {
    JTimer *timer = [[JTimerStore instance] first];
    int minutes = [timer.seconds intValue] / 60;
    int seconds = [timer.seconds intValue] % 60;

    [self.restMinutes setText:[[NSNumber numberWithInt:minutes] stringValue]];
    [self.restSeconds setText:[[NSNumber numberWithInt:seconds] stringValue]];
}

- (void)viewWillDisappear:(BOOL)animated {
    int minutes = [[self.restMinutes text] intValue];
    int seconds = [[self.restSeconds text] intValue];
    [[[JTimerStore instance] first] setSeconds:[NSNumber numberWithInt:(minutes * 60 + seconds)]];
}

- (IBAction)timerTapped:(id)sender {
    [self startTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startTimer {
    int minutes = [[self.restMinutes text] intValue];
    int seconds = [[self.restSeconds text] intValue];
    int totalSeconds = minutes * 60 + seconds;
    [[BLTimer instance] start:totalSeconds];
}

@end