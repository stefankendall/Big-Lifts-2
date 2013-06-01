#import "SSWorkoutDataSourceTests.h"
#import "SSWorkoutDataSource.h"
#import "SSWorkout.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"
#import "BLStoreManager.h"

@implementation SSWorkoutDataSourceTests
@synthesize dataSource;

- (void)setUp {
    [super setUp];
    [[BLStoreManager instance] resetAllStores];
    dataSource = [SSWorkoutDataSource new];
}

- (void)testNumberOfRowsInSection {
    STAssertEquals(3, [dataSource tableView:nil numberOfRowsInSection:0], @"");
}

- (void)testMoveRowAtIndexPathSwapsLiftOrder {
    [dataSource tableView:nil moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    Workout *workout1 = [[dataSource getWorkoutForSection: 0] workouts][0];
    Workout *workout2 = [[dataSource getWorkoutForSection: 0] workouts][1];

    NSString *firstSetLiftName1 = ((Set *) workout1.sets[0]).lift.name;
    STAssertTrue([firstSetLiftName1 isEqualToString:@"Bench"], @"");

    NSString *firstSetLiftName2 = ((Set *) workout2.sets[1]).lift.name;
    STAssertTrue([firstSetLiftName2 isEqualToString:@"Squat"], firstSetLiftName2);
}

- (void)testReturnsIndividualWorkoutNames {
    UITableViewCell *cell1 = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *cell2 = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    NSString *cell1Text = [[cell1 textLabel] text];
    NSString *cell2Text = [[cell2 textLabel] text];
    STAssertFalse( [cell1Text isEqualToString:cell2Text], @"");
}

- (void)testReturnsDifferentLiftsForDifferentSections {
    UITableViewCell *section1LastCell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *section2LastCell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];

    NSString *cell1Text = [[section1LastCell textLabel] text];
    NSString *cell2Text = [[section2LastCell textLabel] text];

    STAssertTrue( [cell1Text isEqualToString:@"Deadlift"], @"");
    STAssertTrue( [cell2Text isEqualToString:@"Power Clean"], @"");
}

- (void) testTargetIndexPathRejectsDifferentSection {
    NSIndexPath *dest = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *source = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *result = [dataSource tableView:nil targetIndexPathForMoveFromRowAtIndexPath:source toProposedIndexPath:dest];
    STAssertEquals(result, source, @"");
}

- (void) testTargetIndexPathAllowsSameSection {
    NSIndexPath *dest = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *source = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *result = [dataSource tableView:nil targetIndexPathForMoveFromRowAtIndexPath:source toProposedIndexPath:dest];
    STAssertEquals(result, dest, @"");
}

@end