#import "Migrate2to3Tests.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "Migrate2to3.h"

@implementation Migrate2to3Tests

-(void) testFindsOrphanedWorkouts {
    JWorkout *workout = [[JWorkoutStore instance] create];
    NSArray *workouts = [[Migrate2to3 new] findOrphanedWorkouts];
    STAssertEquals([workouts count], 1U, @"");
    STAssertEquals(workouts[0], workout, @"");
}

@end