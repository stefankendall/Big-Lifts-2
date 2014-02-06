#import "FTORepsToBeatBreakdownTests.h"
#import "FTORepsToBeatBreakdown.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOWorkoutStore.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JFTOSettingsStore.h"
#import "PaddingTextField.h"
#import "JSet.h"
#import "JLift.h"
#import "JFTOSettings.h"
#import "JFTOCustomWorkout.h"
#import "JWorkout.h"

@implementation FTORepsToBeatBreakdownTests

- (void)testSetsLabelsForSet {
    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    JSet *set = [[[[[JFTOWorkoutStore instance] first] workout] sets] lastObject];
    set.lift.weight = N(150);
    set.reps = @4;
    set.percentage = N(95);

    JSetLog *setLog = [[JSetLogStore instance] create];
    setLog.weight = N(155);
    setLog.name = set.lift.name;
    setLog.reps = @1;
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
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
    JFTOSettings *ftoSettings = [[JFTOSettingsStore instance] first];
    [ftoSettings setRepsToBeatConfig:[NSNumber numberWithInt:kRepsToBeatLogOnly]];
    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    STAssertEquals((int)[[breakdown configPicker] selectedRowInComponent:0], 1, @"");
    STAssertEqualObjects([[breakdown configTextField] text], @"Log Only", @"");
}

- (void)testCanChangeStoredOneRepConfigLogOnly {
    JSet *set = [[[[[JFTOWorkoutStore instance] first] workout] sets] lastObject];
    set.lift.weight = N(150);
    set.reps = @4;
    set.percentage = N(100);

    FTORepsToBeatBreakdown *breakdown = [self getControllerByStoryboardIdentifier:@"ftoRepsToBeat"];
    [breakdown setLastSet:set];

    [breakdown.configPicker selectRow:1 inComponent:0 animated:NO];
    [breakdown textFieldDidEndEditing:nil];
    STAssertEquals([[[[JFTOSettingsStore instance] first] repsToBeatConfig] intValue], kRepsToBeatLogOnly, @"");
    STAssertEqualObjects([[breakdown reps] text], @"0x", @"");
    STAssertEqualObjects([[breakdown weight] text], @"135", @"");
    STAssertEqualObjects([[breakdown estimatedMax] text], @"0", @"");
}

@end