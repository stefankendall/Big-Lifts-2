@protocol TimerObserver;

@interface BLTimer : NSObject

@property(nonatomic) int secondsRemaining;

@property(nonatomic) NSTimer *timer;

@property(nonatomic, weak) UIViewController <TimerObserver> *observer;

+ (instancetype)instance;

- (void)start:(int)seconds;

- (void)stopTimer;

- (void)suspend;

- (void)resume;

- (NSString *)formattedTimeRemaining;

- (BOOL)isRunning;
@end