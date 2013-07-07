#import "SSIndividualWorkoutDataSourceTests.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkoutStore.h"
#import "SetCellWithPlates.h"
#import "IAPAdapter.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "SKProductStore.h"

@implementation SSIndividualWorkoutDataSourceTests

- (void)testReturnsCorrectNumberOfRowsWithWarmup {
    [[IAPAdapter instance] addPurchase:@"ssWarmup"];
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSIndividualWorkoutDataSource *dataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    Workout *workout = ssWorkout.workouts[0];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], (int) [workout.sets count], @"");
}

- (void)testReturnsCorrectNumberOfRowsWithoutWarmup {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSIndividualWorkoutDataSource *dataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    Workout *workout = ssWorkout.workouts[0];
    STAssertEquals([dataSource tableView:nil numberOfRowsInSection:0], 3, @"");
}

- (void)testReturnsPlatesWhenBarLoadingPurchased {
    [[IAPAdapter instance] addPurchase:@"barLoading"];
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSIndividualWorkoutDataSource *dataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    UITableViewCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertTrue([cell isKindOfClass:SetCellWithPlates.class], @"");
}

- (void)testNoPlatesWhenBarLoadingUnpurchased {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    SSIndividualWorkoutDataSource *dataSource = [[SSIndividualWorkoutDataSource alloc] initWithSsWorkout:ssWorkout];
    UITableViewCell *cell = [dataSource tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertFalse([cell isKindOfClass:SetCellWithPlates.class], @"");
}

@end