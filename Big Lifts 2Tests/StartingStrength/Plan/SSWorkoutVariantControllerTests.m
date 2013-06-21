#import "SSWorkoutVariantControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSWorkoutVariantController.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation SSWorkoutVariantControllerTests

- (void)testSelectNoviceWorkoutChangesWorkout {
    SSWorkoutVariantController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkoutVariant"];
    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    SSWorkout *workoutB = [[SSWorkoutStore instance] last];
    Workout *lastWorkout = workoutB.workouts[2];
    Set *firstSet = lastWorkout.sets[0];
    STAssertEqualObjects(firstSet.lift.name, @"Deadlift", @"");
}

@end