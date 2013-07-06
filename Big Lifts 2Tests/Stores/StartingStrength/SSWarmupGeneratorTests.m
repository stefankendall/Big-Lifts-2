#import "SSWarmupGeneratorTests.h"
#import "SSWorkout.h"
#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "SSWarmupGenerator.h"

@implementation SSWarmupGeneratorTests

- (void)testGeneratesSquatWarmup {
    SSWorkout *workoutA = [[SSWorkoutStore instance] find:@"name" value:@"A"];
    Workout *squatWorkout = [self findWorkout:workoutA name:@"Squat"];
    [[SSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals([squatWorkout.sets count], 8U, @"");
    Set *firstSet = [squatWorkout.sets firstObject];
    Set *lastSet = [squatWorkout.sets lastObject];
    STAssertTrue(firstSet.warmup, @"");
    STAssertFalse(lastSet.warmup, @"");
}

- (Workout *)findWorkout:(SSWorkout *)workoutA name:(NSString *)name {
    return [[workoutA.workouts array] detect:^BOOL(Workout *workout) {
        Set *set = workout.sets[0];
        return [set.lift.name isEqualToString:name];
    }];
}

@end