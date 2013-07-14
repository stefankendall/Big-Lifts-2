#import "FTORepsToBeatBreakdownTests.h"
#import "FTORepsToBeatBreakdown.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "Set.h"
#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "Lift.h"
#import "FTOWorkout.h"
#import "SetLog.h"
#import "SetLogStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"

@implementation FTORepsToBeatBreakdownTests

- (void)testSetsLabelsForSet {
    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    Set *set = [[[[[FTOWorkoutStore instance] first] workout] sets] lastObject];
    set.lift.weight = N(150);
    set.reps = @4;
    set.percentage = N(95);

    SetLog *setLog = [[SetLogStore instance] create];
    setLog.weight = N(155);
    setLog.name = set.lift.name;
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    [workoutLog.sets addObject:setLog];

    [breakdown setLastSet:set];
    [breakdown viewWillAppear:YES];

    STAssertEqualObjects([[breakdown enteredOneRepMax] text], @"150", @"");
    STAssertEqualObjects([[breakdown maxFromLog] text], @"155", @"");
    STAssertEqualObjects([[breakdown reps] text], @"6x", @"");
    STAssertEqualObjects([[breakdown weight] text], @"130", @"");
    STAssertEqualObjects([[breakdown estimatedMax] text], @"155.74", @"");
}

@end