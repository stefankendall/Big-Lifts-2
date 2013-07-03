#import "FTOTrackViewControllerTests.h"
#import "BLStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "FTOTrackViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "Set.h"
#import "SetStore.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"
#import "SetLogStore.h"

@implementation FTOTrackViewControllerTests

- (void)testReturnsRowForEachLog {
    [[WorkoutLogStore instance] create];
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";

    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testReturnsLastWorkout {
    [[WorkoutLogStore instance] create];
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    [log.sets addObject:[[SetStore instance] create]];
    [log.sets addObject:[[SetStore instance] create]];
    Set *lastSet = [[SetStore instance] create];
    lastSet.reps = @10;
    [log.sets addObject:lastSet];

    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    WorkoutLogCell *cell = (WorkoutLogCell *) [controller tableView:nil cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([cell.workoutLogTableDataSource tableView:nil numberOfRowsInSection:0], 1, @"");
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testViewButtonTappedTogglesText {
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    [controller viewButtonTapped:nil];
    [controller viewButtonTapped:nil];
    STAssertEqualObjects([controller.viewButton titleForState:UIControlStateNormal], @"Last Set", @"");
}

- (void)testViewButtonTappedShowsAllRows {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    [log.sets addObject:[[SetLogStore instance] create]];
    [log.sets addObject:[[SetLogStore instance] create]];
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([self getCellRowCount:controller], 1, @"");
    [controller viewButtonTapped:nil];
    STAssertEquals([self getCellRowCount:controller], 2, @"");
}

- (int)getCellRowCount:(FTOTrackViewController *)controller {
    WorkoutLogCell *cell = (WorkoutLogCell *) [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return [cell.workoutLogTableDataSource tableView:nil numberOfRowsInSection:0];
}

@end