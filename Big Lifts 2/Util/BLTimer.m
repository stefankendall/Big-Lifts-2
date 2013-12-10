#import "BLTimer.h"
#import "TimerObserver.h"

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

- (void)timerTick:(id)t {
    self.secondsRemaining--;
    if (self.secondsRemaining <= 0) {
        [self stopTimer];
    }
    [self.observer timerTick];
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