#import "JTimerStore.h"
#import "JTimer.h"

@implementation JTimerStore

- (Class)modelClass {
    return JTimer.class;
}

- (void)setupDefaults {
    JTimer *timer = [self create];
    timer.seconds = @120;
}

@end