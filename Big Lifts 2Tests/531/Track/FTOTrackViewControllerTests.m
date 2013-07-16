#import "FTOTrackViewControllerTests.h"
#import "BLStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "FTOTrackViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogTableDataSource.h"
#import "SetLogStore.h"
#import "SetLog.h"

@implementation FTOTrackViewControllerTests

- (void)testReturnsRowForEachLog {
    [[WorkoutLogStore instance] create];
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";

    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testReturnsCorrectRows {
    [[WorkoutLogStore instance] create];
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    [log.sets addObject:[[SetLogStore instance] create]];
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testViewButtonTappedTogglesText {
    FTOTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoTrack"];
    [controller viewButtonTapped:nil];
    [controller viewButtonTapped:nil];
    STAssertEqualObjects(controller.viewButton.title, @"Work Sets", @"");
}

- (void)testViewButtonTappedShowsAllRows {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    SetLog *setLog = [[SetLogStore instance] create];
    setLog.warmup = YES;
    [log.sets addObject:setLog];
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