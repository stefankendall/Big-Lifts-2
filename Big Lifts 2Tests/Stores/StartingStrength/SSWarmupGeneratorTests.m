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
    [squatWorkout.sets removeAllObjects];
    Set *squatSet = [[SetStore instance] create];
    squatSet.lift = [[SSLiftStore instance] find:@"name" value:@"Squat"];
    [squatWorkout.sets addObject:squatSet];
    [[SSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals([squatWorkout.sets count], 6U, @"");
    Set *firstSet = [squatWorkout.sets firstObject];
    Set *lastSet = [squatWorkout.sets lastObject];
    STAssertTrue(firstSet.warmup, @"");
    STAssertTrue([firstSet.reps intValue] > 0, @"");
    STAssertEqualObjects([firstSet effectiveWeight], @45, @"");
    STAssertFalse(lastSet.warmup, @"");
}

- (Workout *)findWorkout:(SSWorkout *)workoutA name:(NSString *)name {
    return [[workoutA.workouts array] detect:^BOOL(Workout *workout) {
        Set *set = workout.sets[0];
        return [set.lift.name isEqualToString:name];
    }];
}

@end