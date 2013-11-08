#import "SJWorkoutSummaryCellTests.h"
#import "SJWorkoutSummaryCell.h"
#import "SJWorkoutStore.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SJWorkoutSummaryCellTests

- (void)testSetsLabelsFromWorkout {
    SJWorkoutSummaryCell *cell = [SJWorkoutSummaryCell create];
    SJWorkout *firstWorkout = [[SJWorkoutStore instance] first];
    [cell setWorkout:firstWorkout];

    STAssertEqualObjects([[cell setsLabel] text], @"6 sets", @"");
    STAssertEqualObjects([[cell repsLabel] text], @"6 reps", @"");
    STAssertEqualObjects([[cell percentageLabel] text], @"70%", @"");
    STAssertEqualObjects([[cell addWeightRangeLabel] text], @"", @"");

    SJWorkout *secondWeekWorkout = [[SJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [cell setWorkout:secondWeekWorkout];
    STAssertEqualObjects([[cell addWeightRangeLabel] text], @"+10-20 lbs", @"");
}

- (void)testAdjustsForKg {
    [[[SettingsStore instance] first] setUnits:@"kg"];
    [[SJWorkoutStore instance] adjustForKg];

    SJWorkoutSummaryCell *cell = [SJWorkoutSummaryCell create];
    SJWorkout *firstWorkout = [[SJWorkoutStore instance] first];
    [cell setWorkout:firstWorkout];

    SJWorkout *secondWeekWorkout = [[SJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [cell setWorkout:secondWeekWorkout];
    STAssertEqualObjects([[cell addWeightRangeLabel] text], @"+5-10 kg", @"");
}

@end