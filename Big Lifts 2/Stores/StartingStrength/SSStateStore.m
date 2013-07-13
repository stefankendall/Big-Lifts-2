#import "SSStateStore.h"
#import "SSState.h"

@implementation SSStateStore

- (void)setupDefaults {
    SSState *state = [self create];
    state.workoutAAlternation = @0;
}

@end