#import "SJSetCellTests.h"
#import "SJSetCell.h"
#import "SJWorkoutStore.h"
#import "SJWorkout.h"
#import "Workout.h"
#import "SJLift.h"
#import "SJLiftStore.h"

@implementation SJSetCellTests

- (void)testSetsLabels {
    SJLift *sjLift = [[SJLiftStore instance] first];
    [sjLift setName:@"Power Clean"];
    [sjLift setWeight:N(200)];

    SJSetCell *cell = [SJSetCell create];
    SJWorkout *sjWorkout = [[SJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    Set *set = [sjWorkout.workout sets][0];
    [cell setSjWorkout:sjWorkout withSet:set];

    STAssertEqualObjects([cell.liftLabel text], @"Power Clean", @"");
    STAssertEqualObjects([cell.repsLabel text], @"6x", @"");
    STAssertEqualObjects([cell.percentageLabel text], @"70%", @"");
    STAssertEqualObjects([cell.weightRangeLabel text], @"150-160 lbs", @"");
}

@end