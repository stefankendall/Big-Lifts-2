#import "FTORepsToBeatCalculatorTests.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "FTORepsToBeatCalculator.h"
#import "SetLog.h"
#import "SetLogStore.h"

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

    SetLog *setLog = [[SetLogStore instance] create];
    setLog.name = @"5/3/1";
    setLog.reps = @5;
    setLog.weight = N(190);

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 7, @"");
}

- (void) testFindRepsToBeat {
    int reps = [[FTORepsToBeatCalculator new] findRepsToBeat: N(200) withWeight: N(180)];
    STAssertEquals(reps, 4, @"");
}

@end