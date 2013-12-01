#import "FTOTrackViewControllerTests.h"
#import "BLStore.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "FTOTrackViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "JFTOSettingsStore.h"
#import "FTOTrackToolbarCell.h"

@implementation FTOTrackViewControllerTests

- (void)testReturnsRowForEachLog {
    [[JWorkoutLogStore instance] create];
    JWorkoutLog *log = [[JWorkoutLogStore instance] create];
    log.name = @"5/3/1";

    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testReturnsCorrectRows {
    [[JWorkoutLogStore instance] create];
    JWorkoutLog *log = [[JWorkoutLogStore instance] create];
    log.name = @"5/3/1";
    [log addSet:[[JSetLogStore instance] create]];
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testViewButtonTappedTogglesText {
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    FTOTrackToolbarCell *cell = (FTOTrackToolbarCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.viewButton titleForState:UIControlStateNormal], @"Work", @"");
    [controller viewButtonTapped:nil];
    cell = (FTOTrackToolbarCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.viewButton titleForState:UIControlStateNormal], @"Last", @"");
    [controller viewButtonTapped:nil];
    cell = (FTOTrackToolbarCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.viewButton titleForState:UIControlStateNormal], @"All", @"");
    [controller viewButtonTapped:nil];
    cell = (FTOTrackToolbarCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([cell.viewButton titleForState:UIControlStateNormal], @"Work", @"");
}

- (void)testViewButtonTappedChangesView {
    JWorkoutLog *log = [[JWorkoutLogStore instance] create];
    log.name = @"5/3/1";
    JSetLog *setLog = [[JSetLogStore instance] create];
    setLog.warmup = YES;
    [log addSet:setLog];
    [log addSet:[[JSetLogStore instance] create]];
    [log addSet:[[JSetLogStore instance] create]];
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    int TWO_WORK_SETS = 2;
    STAssertEquals([self getCellRowCount:controller], TWO_WORK_SETS, @"");
    [controller viewButtonTapped:nil];
    int ONE_FINAL_SET = 1;
    STAssertEquals([self getCellRowCount:controller], ONE_FINAL_SET, @"");
    [controller viewButtonTapped:nil];
    int ALL_SETS = 3;
    STAssertEquals([self getCellRowCount:controller], ALL_SETS, @"");
}

- (void)testSortsByDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];

    JWorkoutLog *log1 = [[JWorkoutLogStore instance] create];
    log1.name = @"5/3/1";
    log1.date = [df dateFromString:@"2013-01-12"];

    JWorkoutLog *log2 = [[JWorkoutLogStore instance] create];
    log2.name = @"5/3/1";
    log2.date = [df dateFromString:@"2013-02-01"];

    JWorkoutLog *log3 = [[JWorkoutLogStore instance] create];
    log3.name = @"5/3/1";
    log3.date = [df dateFromString:@"2013-01-17"];

    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    NSArray *expected = @[log2, log3, log1];
    STAssertEqualObjects([controller getLog], expected, @"");
}

- (void)testDoesNotSegueWhenToolbarTapped {
    JWorkoutLog *log1 = [[JWorkoutLogStore instance] create];
    log1.name = @"5/3/1";
    UINavigationController *nav = [self getControllerByStoryboardIdentifier:@"ftoTrackNavController"];
    FTOTrackViewController *controller = [nav viewControllers][0];
    int oldCount = [controller.navigationController.viewControllers count];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([controller.navigationController.viewControllers count], (NSUInteger) oldCount, @"");
}

- (void)testStartsLogStateInSavedState {
    [[[JFTOSettingsStore instance] first] setLogState:[NSNumber numberWithInt:kShowAmrap]];
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals(controller.showState, kShowAmrap, @"");
}

- (void)testCanSortLogAlphabetically {
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd"];
    JWorkoutLog *oldBench = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[df dateFromString:@"2013-01-01"]];
    [oldBench addSet:[[JSetLogStore instance] createWithName:@"Bench" weight:N(200) reps:5 warmup:NO assistance:NO amrap:YES]];
    JWorkoutLog *oldSquat = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[df dateFromString:@"2013-01-03"]];
    [oldSquat addSet:[[JSetLogStore instance] createWithName:@"Squat" weight:N(300) reps:5 warmup:NO assistance:NO amrap:YES]];
    JWorkoutLog *newBench = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[df dateFromString:@"2013-01-05"]];
    [newBench addSet:[[JSetLogStore instance] createWithName:@"Bench" weight:N(205) reps:5 warmup:NO assistance:NO amrap:YES]];
    JWorkoutLog *newSquat = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[df dateFromString:@"2013-01-07"]];
    [newSquat addSet:[[JSetLogStore instance] createWithName:@"Squat" weight:N(310) reps:5 warmup:NO assistance:NO amrap:YES]];

    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([controller getLog][0], newSquat, @"");
    STAssertEquals([controller getLog][1], newBench, @"");
    STAssertEquals([controller getLog][2], oldSquat, @"");
    STAssertEquals([controller getLog][3], oldBench, @"");

    [controller sortButtonTapped:nil];

    STAssertEquals([controller getLog][0], newBench, @"");
    STAssertEquals([controller getLog][1], oldBench, @"");
    STAssertEquals([controller getLog][2], newSquat, @"");
    STAssertEquals([controller getLog][3], oldSquat, @"");
}

- (int)getCellRowCount:(FTOTrackViewController *)controller {
    WorkoutLogCell *cell = (WorkoutLogCell *) [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    return [cell.workoutLogTableDataSource tableView:nil numberOfRowsInSection:0];
}

@end