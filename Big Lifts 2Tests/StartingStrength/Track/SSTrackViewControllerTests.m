#import "SSTrackViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSTrackViewController.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLogStore.h"
#import "WorkoutLogCell.h"

@interface SSTrackViewControllerTests ()
@property(nonatomic) SSTrackViewController *controller;
@end

@implementation SSTrackViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ssTrackViewControllerRoot"];
}

- (void)createWorkoutLog {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"Starting Strength";
    [workoutLog addSet:[[JSetLogStore instance] create]];
    [workoutLog addSet:[[JSetLogStore instance] create]];
    [workoutLog addSet:[[JSetLogStore instance] create]];
}

- (void)testHeightForRowAtIndexPathIsNonZeroAfterDelete {
    [self createWorkoutLog];
    [self createWorkoutLog];

    CGFloat height = [self.controller tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue( height > 0, @"");
}

- (void)testReturnsWorkoutLogCell {
    [self createWorkoutLog];
    WorkoutLogCell *cell = (WorkoutLogCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertNotNil([cell setTable], @"");
}

- (void)testReturnsCorrectNumberOfRows {
    [self createWorkoutLog];
    STAssertEquals((int)[self.controller tableView:nil numberOfRowsInSection:1], 1, @"");
}

- (void)testFiltersByLogName {
    JWorkoutLog *log = [[JWorkoutLogStore instance] create];
    log.name = @"5/3/1";
    STAssertEquals((int)[self.controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testDeletesWorkoutLogs {
    [self createWorkoutLog];
    [self createWorkoutLog];
    [self.controller tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([[JWorkoutLogStore instance] count], 1, @"");
}

@end