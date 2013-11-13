#import "FTORepsToBeatBreakdownTests.h"
#import "FTORepsToBeatBreakdown.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "Set.h"
#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "Lift.h"
#import "FTOWorkout.h"
#import "SetLog.h"
#import "SetLogStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "FTOSettings.h"
#import "FTOSettingsStore.h"
#import "PaddingTextField.h"

@implementation FTORepsToBeatBreakdownTests

- (void)testSetsLabelsForSet {
    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    Set *set = [[[[[FTOWorkoutStore instance] first] workout] sets] lastObject];
    set.lift.weight = N(150);
    set.reps = @4;
    set.percentage = N(95);

    SetLog *setLog = [[SetLogStore instance] create];
    setLog.weight = N(155);
    setLog.name = set.lift.name;
    setLog.reps = @1;
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    [workoutLog addSet:setLog];

    [breakdown setLastSet:set];
    [breakdown viewWillAppear:YES];

    STAssertEqualObjects([[breakdown enteredOneRepMax] text], @"150", @"");
    STAssertEqualObjects([[breakdown maxFromLog] text], @"155", @"");
    STAssertEqualObjects([[breakdown reps] text], @"6x", @"");
    STAssertEqualObjects([[breakdown weight] text], @"130", @"");
    STAssertEqualObjects([[breakdown estimatedMax] text], @"156", @"");
}

- (void)testSetsStoredOneRepConfig {
    FTOSettings *ftoSettings = [[FTOSettingsStore instance] first];
    [ftoSettings setRepsToBeatConfig:[NSNumber numberWithInt:kRepsToBeatLogOnly]];
    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    STAssertEquals([[breakdown configPicker] selectedRowInComponent:0], 1, @"");
    STAssertEqualObjects([[breakdown configTextField] text], @"Log Only", @"");
}

- (void)testCanChangeStoredOneRepConfigLogOnly {
    Set *set = [[[[[FTOWorkoutStore instance] first] workout] sets] lastObject];
    set.lift.weight = N(150);
    set.reps = @4;
    set.percentage = N(100);

    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    [breakdown setLastSet:set];

    [breakdown.configPicker selectRow:1 inComponent:0 animated:NO];
    [breakdown textFieldDidEndEditing:nil];
    STAssertEquals([[[[FTOSettingsStore instance] first] repsToBeatConfig] intValue], kRepsToBeatLogOnly, @"");
    STAssertEqualObjects([[breakdown reps] text], @"0x", @"");
    STAssertEqualObjects([[breakdown weight] text], @"135", @"");
    STAssertEqualObjects([[breakdown estimatedMax] text], @"0", @"");
}

@end