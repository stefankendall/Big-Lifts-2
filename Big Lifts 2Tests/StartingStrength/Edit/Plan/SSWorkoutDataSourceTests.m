#import "SSWorkoutDataSourceTests.h"
#import "SSWorkoutStore.h"
#import "SSWorkoutDataSource.h"
#import "SSWorkout.h"
#import "SSLift.h"
#import "Workout.h"
#import "Set.h"
#import "BLStoreManager.h"

@implementation SSWorkoutDataSourceTests

- (void)setUp {
    [super setUp];
    [[BLStoreManager instance] resetAllStores];
}

- (void)testNumberOfRowsInSection {
    SSWorkoutDataSource *source = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    STAssertEquals(3, [source tableView:nil numberOfRowsInSection:0], @"");
}

- (void)testMoveRowAtIndexPathSwapsLiftOrder {
    SSWorkoutDataSource *source = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    [source tableView:nil moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    Workout *workout1 = [[source getWorkout] workouts][0];
    Workout *workout2 = [[source getWorkout] workouts][1];

    NSString *firstSetLiftName1 = ((Set *) workout1.sets[0]).lift.name;
    STAssertTrue([firstSetLiftName1 isEqualToString:@"Bench"], @"");

    NSString *firstSetLiftName2 = ((Set *) workout2.sets[1]).lift.name;
    STAssertTrue([firstSetLiftName2 isEqualToString:@"Squat"], firstSetLiftName2);
}

- (void)testReturnsIndividualWorkoutNames {
    SSWorkoutDataSource *source = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    UITableViewCell *cell1 = [source tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *cell2 = [source tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    NSString *cell1Text = [[cell1 textLabel] text];
    NSString *cell2Text = [[cell2 textLabel] text];
    STAssertFalse( [cell1Text isEqualToString:cell2Text], @"");

}

@end