#import "SetCellWithPlatesTests.h"
#import "BLStoreManager.h"
#import "SetCellWithPlates.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"

@implementation SetCellWithPlatesTests

- (void) setUp {
    [super setUp];
    [[BLStoreManager instance] resetAllStores];
}

-(void) testSetCellSetsPlates {
    SetCellWithPlates *cell = [SetCellWithPlates createNewTextCellFromNib];

    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    [set setWeight:[NSNumber numberWithDouble:300.0]];
    [cell setSet:set];

    STAssertEqualObjects([[cell platesLabel] text], @"[45, 45, 35, 2.5]", @"");
}

@end