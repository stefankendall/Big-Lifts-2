#import "BLTimer.h"
#import "TimerObserver.h"
#import <AudioToolbox/AudioToolbox.h>

const NSString *TIMER_SECONDS_REMAINING_KEY = @"timerSecondsRemaining";
const NSString *TIMER_SUSPEND_DATE_KEY = @"timerSuspendDate";

@implementation BLTimer

+ (instancetype)instance {
    static BLTimer *timer = nil;
    static dispatch_once_t onceToken = 0;

    dispatch_once(&onceToken, ^{
        timer = [BLTimer new];
    });

    return timer;
}

- (void)start:(int)seconds {
    [self stopTimer];
    self.secondsRemaining = seconds;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [self scheduleBackgroundNotification];
    [self.observer timerTick];
}

- (void)stopTimer {
    self.secondsRemaining = 0;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)endTimer {
    [self stopTimer];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)suspend {
    if (self.secondsRemaining > 0) {
        [[NSUserDefaults standardUserDefaults]              setObject:
                [NSNumber numberWithInt:self.secondsRemaining] forKey:TIMER_SECONDS_REMAINING_KEY];

        [[NSUserDefaults standardUserDefaults] setObject:[NSDate new] forKey:TIMER_SUSPEND_DATE_KEY];
    }
    [self stopTimer];
}

- (void)scheduleBackgroundNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:[self getNotification]];
}

- (UILocalNotification *)getNotification {
    UILocalNotification *notification = [UILocalNotification new];
    notification.fireDate = [[NSDate new] dateByAddingTimeInterval:self.secondsRemaining];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = @"Rest over";
    notification.alertAction = @"go to workout";
    notification.soundName = UILocalNotificationDefaultSoundName;
    return notification;
}

- (void)resume {
    NSNumber *secondsRemaining = [[NSUserDefaults standardUserDefaults] objectForKey:TIMER_SECONDS_REMAINING_KEY];
    if (secondsRemaining != nil) {
        NSDate *suspendDate = [[NSUserDefaults standardUserDefaults] objectForKey:TIMER_SUSPEND_DATE_KEY];
        NSDate *now = [NSDate new];
        int secondsElapsed = (int) (now.timeIntervalSince1970 - suspendDate.timeIntervalSince1970);
        [self start:[secondsRemaining intValue] - secondsElapsed];

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TIMER_SUSPEND_DATE_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:TIMER_SUSPEND_DATE_KEY];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TIMER_SECONDS_REMAINING_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:TIMER_SECONDS_REMAINING_KEY];
    }
}

- (void)timerTick:(id)t {
    self.secondsRemaining--;
    if (self.secondsRemaining <= 0) {
        [self timerDone];
        [self stopTimer];
    }
    [self.observer timerTick];
}

- (void)timerDone {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (NSString *)formattedTimeRemaining {
    int minutes = self.secondsRemaining / 60;
    int seconds = self.secondsRemaining % 60;

    return [NSString stringWithFormat:@"%i:%02i", minutes, seconds];
}

- (BOOL)isRunning {
    return self.secondsRemaining > 0;
}

@end