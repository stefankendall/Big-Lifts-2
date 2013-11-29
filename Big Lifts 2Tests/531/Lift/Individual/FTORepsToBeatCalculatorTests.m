#import "FTORepsToBeatCalculatorTests.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "FTORepsToBeatCalculator.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTORepsToBeatCalculatorTests

- (void)testGivesRepsToBeatBasedOnTheMax {
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 4, @"");
}

- (void)testGivesRepsToBeatBasedOnTheLog {
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    JSetLog *setLog = [[JSetLogStore instance] create];
    setLog.name = @"Squat";
    setLog.reps = @5;
    setLog.weight = N(190);
    [workoutLog addSet:setLog];

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 7, @"");
}

- (void)testDoesNotUseEnteredMaxesWhenConfigIsLogOnly {
    [[[FTOSettingsStore instance] first] setRepsToBeatConfig:[NSNumber numberWithInt:kRepsToBeatLogOnly]];

    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    JSetLog *setLog = [[JSetLogStore instance] create];
    setLog.name = @"Squat";
    setLog.reps = @1;
    setLog.weight = N(190);
    [workoutLog addSet:setLog];

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 2, @"");
}

- (void)testReturns0WhenConfigIsLogOnlyAndNoLog {
    [[[FTOSettingsStore instance] first] setRepsToBeatConfig:[NSNumber numberWithInt:kRepsToBeatLogOnly]];

    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    JSetLog *setLog = [[JSetLogStore instance] create];
    setLog.name = @"Deadlift";
    setLog.reps = @1;
    setLog.weight = N(190);
    [workoutLog addSet:setLog];

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 0, @"");
}

- (void)testFindRepsToBeat {
    int reps = [[FTORepsToBeatCalculator new] findRepsToBeat:N(200) withWeight:N(180)];
    STAssertEquals(reps, 4, @"");
}

@end