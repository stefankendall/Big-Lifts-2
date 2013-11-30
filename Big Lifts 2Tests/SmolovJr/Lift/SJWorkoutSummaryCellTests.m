#import "SJWorkoutSummaryCellTests.h"
#import "SJWorkoutSummaryCell.h"
#import "JSJWorkoutStore.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation SJWorkoutSummaryCellTests

- (void)testSetsLabelsFromWorkout {
    SJWorkoutSummaryCell *cell = [SJWorkoutSummaryCell create];
    JSJWorkout *firstWorkout = [[JSJWorkoutStore instance] first];
    [cell setWorkout:firstWorkout];

    STAssertEqualObjects([[cell setsLabel] text], @"6 sets", @"");
    STAssertEqualObjects([[cell repsLabel] text], @"6 reps", @"");
    STAssertEqualObjects([[cell percentageLabel] text], @"70%", @"");
    STAssertEqualObjects([[cell addWeightRangeLabel] text], @"", @"");

    JSJWorkout *secondWeekWorkout = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [cell setWorkout:secondWeekWorkout];
    STAssertEqualObjects([[cell addWeightRangeLabel] text], @"+10-20 lbs", @"");
}

- (void)testAdjustsForKg {
    [[[JSettingsStore instance] first] setUnits:@"kg"];
    [[JSJWorkoutStore instance] adjustForKg];

    SJWorkoutSummaryCell *cell = [SJWorkoutSummaryCell create];
    JSJWorkout *firstWorkout = [[JSJWorkoutStore instance] first];
    [cell setWorkout:firstWorkout];

    JSJWorkout *secondWeekWorkout = [[JSJWorkoutStore instance] findAllWhere:@"week" value:@2][0];
    [cell setWorkout:secondWeekWorkout];
    STAssertEqualObjects([[cell addWeightRangeLabel] text], @"+5-10 kg", @"");
}

@end