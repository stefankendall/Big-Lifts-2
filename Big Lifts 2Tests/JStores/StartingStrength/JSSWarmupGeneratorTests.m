#import "JSSWarmupGeneratorTests.h"
#import "JSSWorkout.h"
#import "BLJStore.h"
#import "JSSWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "JWorkout.h"
#import "JSet.h"
#import "JLift.h"
#import "JSSWarmupGenerator.h"
#import "JSetStore.h"
#import "JSSLiftStore.h"

@implementation JSSWarmupGeneratorTests

- (void)testGeneratesSquatWarmup {
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] find:@"name" value:@"A"];
    JWorkout *squatWorkout = [self findWorkout:workoutA name:@"Squat"];
    [squatWorkout removeSets:squatWorkout.orderedSets];
    JSet *squatSet = [[JSetStore instance] create];
    squatSet.lift = [[JSSLiftStore instance] find:@"name" value:@"Squat"];
    [squatWorkout addSet:squatSet];
    [[JSSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals([squatWorkout.orderedSets count], 6U, @"");
    JSet *firstSet = [squatWorkout.orderedSets firstObject];
    JSet *lastSet = [squatWorkout.orderedSets lastObject];
    STAssertTrue(firstSet.warmup, @"");
    STAssertTrue([firstSet.reps intValue] > 0, @"");
    STAssertEqualObjects([firstSet effectiveWeight], @45, @"");
    STAssertFalse(lastSet.warmup, @"");
}

- (void)testCanRemoveWarmups {
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] find:@"name" value:@"A"];
    JWorkout *squatWorkout = [self findWorkout:workoutA name:@"Squat"];
    [[JSSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals([squatWorkout.orderedSets count], 8U, @"");
    [[JSSWarmupGenerator new] removeWarmup:squatWorkout];
    STAssertEquals([squatWorkout.orderedSets count], 3U, @"");
}

- (JWorkout *)findWorkout:(JSSWorkout *)workoutA name:(NSString *)name {
    return [workoutA.workouts detect:^BOOL(JWorkout *workout) {
        JSet *set = workout.orderedSets[0];
        return [set.lift.name isEqualToString:name];
    }];
}

@end