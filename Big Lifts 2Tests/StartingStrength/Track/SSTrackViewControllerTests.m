#import "SSTrackViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSTrackViewController.h"
#import "BLStoreManager.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLogStore.h"

@implementation SSTrackViewControllerTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
}

- (void)testHeightForRowAtIndexPathIsNonZeroAfterDelete {
    [self createWorkoutLog];
    [self createWorkoutLog];

    SSTrackViewController *controller = [self getControllerByStoryboardIdentifier:@"ssTrackViewControllerRoot"];
    CGFloat height = [controller tableView:nil heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue( height > 0, @"");
}

- (void)createWorkoutLog {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    [workoutLog.sets addObject:[[SetLogStore instance] create]];
    [workoutLog.sets addObject:[[SetLogStore instance] create]];
    [workoutLog.sets addObject:[[SetLogStore instance] create]];
}
@end