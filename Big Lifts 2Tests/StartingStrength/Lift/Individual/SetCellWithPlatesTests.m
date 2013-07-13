#import "SetCellWithPlatesTests.h"
#import "BLStoreManager.h"
#import "SetCellWithPlates.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"

@implementation SetCellWithPlatesTests

-(void) testSetCellSetsPlates {
    SetCellWithPlates *cell = [SetCellWithPlates create];

    SSWorkout *ssWorkout = [[SSWorkoutStore instance] first];
    Workout *workout = [ssWorkout workouts][0];
    Set *set = workout.sets[0];
    set.percentage = N(100);
    set.lift.weight = N(300);
    [cell setSet:set];

    STAssertEqualObjects([[cell platesLabel] text], @"[45, 45, 35, 2.5]", @"");
}

@end