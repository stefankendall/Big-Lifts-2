#import <FlurrySDK/Flurry.h>
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

    [self.restMinutes setText:[@(minutes) stringValue]];
    [self.restSeconds setText:[@(seconds) stringValue]];

    if ([[BLTimer instance] isRunning]) {
        [self.startStopButton setTitle:@"Stop"];
    }
    else {
        [self.startStopButton setTitle:@"Start"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    int minutes = [[self.restMinutes text] intValue];
    int seconds = [[self.restSeconds text] intValue];
    [[[JTimerStore instance] first] setSeconds:@(minutes * 60 + seconds)];
}

- (IBAction)timerTapped:(id)sender {
    if ([[BLTimer instance] isRunning]) {
        [Flurry logEvent:@"Rest_Stop"];
        [[BLTimer instance] endTimer];
        [self.startStopButton setTitle:@"Start"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [Flurry logEvent:@"Rest_Start"];
        [self startTimer];
        [self.startStopButton setTitle:@"Stop"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)startTimer {
    int minutes = [[self.restMinutes text] intValue];
    int seconds = [[self.restSeconds text] intValue];
    int totalSeconds = minutes * 60 + seconds;
    [[BLTimer instance] start:totalSeconds];
}

@end