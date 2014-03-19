#import "JFTOFullCustomPlanTests.h"
#import "JFTOFullCustomPlan.h"
#import "JFTOFullCustomWeekStore.h"
#import "JFTOLiftStore.h"
#import "JFTOFullCustomWorkout.h"
#import "JWorkout.h"

@implementation JFTOFullCustomPlanTests

- (void)testHasData {
    JFTOFullCustomPlan *plan = [JFTOFullCustomPlan new];
    STAssertNotNil([plan deloadWeeks], @"");
    STAssertNotNil([plan weekNames], @"");
    STAssertNotNil([plan incrementMaxesWeeks], @"");
    STAssertNotNil([plan generate:nil], @"");
}

- (void)testGeneratedDataLooksRight {
    JFTOFullCustomPlan *plan = [JFTOFullCustomPlan new];
    NSDictionary *generatedPlan = [plan generate:[[JFTOLiftStore instance] find:@"name" value:@"Squat"]];
    NSArray *workoutPlan = generatedPlan[@1];
    STAssertEquals((int) [workoutPlan count], 6, @"");
}

- (void)testFindsWorkoutForLift {
    JFTOFullCustomPlan *plan = [JFTOFullCustomPlan new];
    JLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    JFTOFullCustomWorkout *customWorkout = [plan workoutForLift:squat
                                                         inWeek:[[JFTOFullCustomWeekStore instance] first]];
    STAssertNotNil(customWorkout, @"");
    STAssertEquals([[customWorkout.workout.sets firstObject] lift], squat, @"");
}

@end