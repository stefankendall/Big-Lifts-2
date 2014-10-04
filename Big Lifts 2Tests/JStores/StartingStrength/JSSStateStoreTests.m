#import "JSSWorkout.h"
#import "JSSStateStoreTests.h"
#import "JSSStateStore.h"
#import "JSSState.h"
#import "JSSWorkoutStore.h"

@implementation JSSStateStoreTests

- (void)testCanDeserializeStateWithBadWorkoutAssociation {
    NSString *serialized = @"{\"uuid\":\"1\", \"workoutAAlternation\":1,\"lastWorkout\":\"1234-bad\"}";
    JSSState *state = (JSSState *) [[JSSStateStore instance] deserializeObject:serialized];
    STAssertEqualObjects(state.workoutAAlternation, @1, @"");
    STAssertNil(state.lastWorkout, @"");
}

- (void)testSerializesSSWorkoutIntoUuid {
    JSSState *state = [[JSSStateStore instance] first];
    state.lastWorkout = [[JSSWorkoutStore instance] first];
    NSArray *serialized = [[JSSStateStore instance] serialize];
    NSString *serializedObject = serialized[0];
    NSString *targetString = [NSString stringWithFormat:@"lastWorkout\":\"%@\"",state.lastWorkout.uuid];
    STAssertTrue([serializedObject rangeOfString:targetString].location != NSNotFound, @"");
}

@end