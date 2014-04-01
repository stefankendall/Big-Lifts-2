#import "FTORepsToBeatCalculatorTests.h"
#import "JFTOLiftStore.h"
#import "FTORepsToBeatCalculator.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "JFTOSettingsStore.h"
#import "JFTOLift.h"
#import "JFTOSettings.h"

@implementation FTORepsToBeatCalculatorTests

- (void)testGivesRepsToBeatBasedOnTheMax {
    JFTOLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 4, @"");
}

- (void)testGivesRepsToBeatBasedOnTheLog {
    JFTOLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
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
    [[[JFTOSettingsStore instance] first] setRepsToBeatConfig:[NSNumber numberWithInt:kRepsToBeatLogOnly]];

    JFTOLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
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
    [[[JFTOSettingsStore instance] first] setRepsToBeatConfig:[NSNumber numberWithInt:kRepsToBeatLogOnly]];

    JFTOLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
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

- (void)testUsesWorksetsForFindingMatchingLogs {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    JSetLog *workSetLog = [[JSetLogStore instance] create];
    workSetLog.name = @"Deadlift";
    [workoutLog addSet:workSetLog];

    JSetLog *assistance = [[JSetLogStore instance] createWithName:@"Press" weight:N(100) reps:3 warmup:NO assistance:YES amrap:NO];
    [workoutLog addSet:assistance];

    NSArray *logs = [[FTORepsToBeatCalculator new] logsForLift:[[JFTOLiftStore instance] find:@"name" value:@"Deadlift"]];
    STAssertEquals((int) [logs count], 1, @"");
}

- (void)testFindLogMaxForLiftUsesWorkSets {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    JSetLog *workSetLog = [[JSetLogStore instance] create];
    workSetLog.reps = @1;
    workSetLog.name = @"Deadlift";
    workSetLog.weight = N(150);
    [workoutLog addSet:workSetLog];

    JSetLog *assistance = [[JSetLogStore instance] createWithName:@"Deadlift" weight:N(100) reps:3 warmup:NO assistance:YES amrap:NO];
    [workoutLog addSet:assistance];

    NSDecimalNumber *max = [[FTORepsToBeatCalculator new] findLogMax:[[JFTOLiftStore instance] find: @"name" value: @"Deadlift"]];
    STAssertEqualObjects(max, N(150), @"");
}

@end