#import "FTORepsToBeatCalculatorTests.h"
#import "FTOLift.h"
#import "FTOLiftStore.h"
#import "FTORepsToBeatCalculator.h"

@implementation FTORepsToBeatCalculatorTests

- (void)testGivesRepsToBeatBasedOnTheMax {
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = N(200);

    int repsToBeat = [[FTORepsToBeatCalculator new] repsToBeat:squat atWeight:N(180)];
    STAssertEquals(repsToBeat, 4, @"");
}

@end