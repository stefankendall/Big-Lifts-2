#import "WorkoutSharerTests.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "WorkoutSharer.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"

@implementation WorkoutSharerTests

- (void)testCreatesWorkoutSummaries {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    JFTOLift *lift = [[JFTOLiftStore instance] find:@"name" value:@"Bench"];
    lift.weight = N(200);
    NSString *expected = @"My workout:\nBench 5x 70lbs\n"
            "5x 90lbs\n"
            "3x 110lbs\n"
            "5x 115lbs\n"
            "5x 135lbs\n"
            "5+ 155lbs\n";
    NSString *summary = [[WorkoutSharer new] workoutSummary:ftoWorkout.workout];STAssertEqualObjects(summary, expected, @"");
    STAssertTrue((int) summary.length < 140, @"");
}

@end