#import "BLTimer.h"
#import "TimerObserver.h"
#import <AudioToolbox/AudioToolbox.h>

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
    [self.observer timerTick];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
    }
}

- (void)suspend {
    if (self.timer) {
        [[NSUbiquitousKeyValueStore defaultStore]           setObject:
                [NSNumber numberWithInt:self.secondsRemaining] forKey:@"timerSecondsRemaining"];

        [[NSUbiquitousKeyValueStore defaultStore] setObject:[NSDate new] forKey:@"timerSuspendDate"];
        [self.timer invalidate];
    }
}

- (void)resume {
    NSNumber *secondsRemaining = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:@"timerSecondsRemaining"];
    if (secondsRemaining) {
        NSDate *suspendDate = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:@"timerSuspendDate"];
        NSDate *now = [NSDate new];
        int secondsElapsed = (int) (now.timeIntervalSince1970 - suspendDate.timeIntervalSince1970);
        [self start:[secondsRemaining intValue] - secondsElapsed];

        [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:@"timerSuspendDate"];
        [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:@"timerSecondsRemaining"];
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