#import "JSSStateStore.h"
#import "JSSState.h"

@implementation JSSStateStore

- (Class)modelClass {
    return JSSState.class;
}

- (void)setupDefaults {
    JSSState *state = [self create];
    state.workoutAAlternation = @0;
}

@end