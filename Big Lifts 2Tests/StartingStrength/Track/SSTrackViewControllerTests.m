#import "SSTrackViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSTrackViewController.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogStore.h"
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
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.name = @"Starting Strength";
    [workoutLog.sets addObject:[[SetLogStore instance] create]];
    [workoutLog.sets addObject:[[SetLogStore instance] create]];
    [workoutLog.sets addObject:[[SetLogStore instance] create]];
}

- (void)testHeightForRowAtIndexPathIsNonZeroAfterDelete {
    [self createWorkoutLog];
    [self createWorkoutLog];

    CGFloat height = [self.controller tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue( height > 0, @"");
}

- (void)testReturnsWorkoutLogCell {
    [self createWorkoutLog];
    WorkoutLogCell *cell = (WorkoutLogCell *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertNotNil([cell setTable], @"");
}

- (void)testReturnsCorrectNumberOfRows {
    [self createWorkoutLog];
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 1, @"");
}

- (void)testFiltersByLogName {
    WorkoutLog *log = [[WorkoutLogStore instance] create];
    log.name = @"5/3/1";
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 0, @"");
}

- (void)testDeletesWorkoutLogs {
    [self createWorkoutLog];
    [self createWorkoutLog];
    [self.controller tableView:nil commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([[WorkoutLogStore instance] count], 1, @"");
}

@end