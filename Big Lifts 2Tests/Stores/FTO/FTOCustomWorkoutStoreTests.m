#import "FTOCustomWorkoutStoreTests.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"

@implementation FTOCustomWorkoutStoreTests

-(void) testSetsUpDefaultData {
    NSArray *customWorkouts = [[FTOCustomWorkoutStore instance] findAll];
    STAssertEquals([customWorkouts count], 16U, @"");

    FTOCustomWorkout *customWorkout = customWorkouts[0];
    STAssertEquals([[customWorkout.workout sets] count], 6U, @"");
}

@end