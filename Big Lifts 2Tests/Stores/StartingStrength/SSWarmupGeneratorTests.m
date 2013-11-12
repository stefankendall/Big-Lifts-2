#import "SSWarmupGeneratorTests.h"
#import "SSWorkout.h"
#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "SSWarmupGenerator.h"
#import "SetStore.h"
#import "SSLiftStore.h"

@implementation SSWarmupGeneratorTests

- (void)testGeneratesSquatWarmup {
    SSWorkout *workoutA = [[SSWorkoutStore instance] find:@"name" value:@"A"];
    Workout *squatWorkout = [self findWorkout:workoutA name:@"Squat"];
    [squatWorkout removeSets:squatWorkout.orderedSets];
    Set *squatSet = [[SetStore instance] create];
    squatSet.lift = [[SSLiftStore instance] find:@"name" value:@"Squat"];
    [squatWorkout addSet:squatSet];
    [[SSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals([squatWorkout.orderedSets count], 6U, @"");
    Set *firstSet = [squatWorkout.orderedSets firstObject];
    Set *lastSet = [squatWorkout.orderedSets lastObject];
    STAssertTrue(firstSet.warmup, @"");
    STAssertTrue([firstSet.reps intValue] > 0, @"");
    STAssertEqualObjects([firstSet effectiveWeight], @45, @"");
    STAssertFalse(lastSet.warmup, @"");
}

- (void)testCanRemoveWarmups {
    SSWorkout *workoutA = [[SSWorkoutStore instance] find:@"name" value:@"A"];
    Workout *squatWorkout = [self findWorkout:workoutA name:@"Squat"];
    [[SSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals([squatWorkout.orderedSets count], 8U, @"");
    [[SSWarmupGenerator new] removeWarmup:squatWorkout];
    STAssertEquals([squatWorkout.orderedSets count], 3U, @"");
}

- (Workout *)findWorkout:(SSWorkout *)workoutA name:(NSString *)name {
    return [[workoutA.workouts array] detect:^BOOL(Workout *workout) {
        Set *set = workout.orderedSets[0];
        return [set.lift.name isEqualToString:name];
    }];
}

@end