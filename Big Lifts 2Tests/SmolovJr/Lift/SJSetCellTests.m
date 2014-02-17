#import "SJSetCellTests.h"
#import "SJSetCell.h"
#import "JSJWorkoutStore.h"
#import "JSJWorkout.h"
#import "JWorkout.h"
#import "JSJLift.h"
#import "JSJLiftStore.h"

@implementation SJSetCellTests

- (void)testSetsLabels {
    JSJLift *sjLift = [[JSJLiftStore instance] first];
    [sjLift setName:@"Power Clean"];
    [sjLift setWeight:N(200)];

    SJSetCell *cell = [SJSetCell create];
    JSJWorkout *sjWorkout = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    JSet *set = sjWorkout.workout.sets[0];
    [cell setSjWorkout:sjWorkout withSet:set withEnteredWeight:nil];

    STAssertEqualObjects([cell.liftLabel text], @"Power Clean", @"");
    STAssertEqualObjects([cell.repsLabel text], @"6x", @"");
    STAssertEqualObjects([cell.percentageLabel text], @"70%", @"");
    STAssertEqualObjects([cell.weightRangeLabel text], @"150-160 lbs", @"");
}

- (void)testSetsEnteredWeightIfAvailable {
    SJSetCell *cell = [SJSetCell create];
    JSJWorkout *sjWorkout = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    JSet *set = sjWorkout.workout.sets[0];
    [cell setSjWorkout:sjWorkout withSet:set withEnteredWeight:N(150)];
    STAssertEqualObjects([cell.weightRangeLabel text], @"150 lbs", @"");
}

@end