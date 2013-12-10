@protocol TimerObserver;

@interface BLTimer : NSObject

@property(nonatomic) int secondsRemaining;

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, weak) UIViewController <TimerObserver> *observer;

+ (instancetype)instance;

- (void)start:(int)seconds;

- (void)suspend;

- (void)resume;

- (NSString *)formattedTimeRemaining;

- (BOOL)isRunning;
@end