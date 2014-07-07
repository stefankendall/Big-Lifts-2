#import "JSSStateStoreTests.h"
#import "JSSStateStore.h"
#import "JSSState.h"

@implementation JSSStateStoreTests

- (void)testCanDeserializeStateWithBadWorkoutAssociation {
    NSString *serialized = @"{\"uuid\":\"1\", \"workoutAAlternation\":1,\"lastWorkout\":\"1234-bad\"}";
    JSSState *state = (JSSState *) [[JSSStateStore instance] deserializeObject:serialized];
    STAssertEqualObjects(state.workoutAAlternation, @1, @"");
    STAssertNil(state.lastWorkout, @"");
}

@end