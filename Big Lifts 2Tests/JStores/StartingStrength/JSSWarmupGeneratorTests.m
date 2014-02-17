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
    [squatWorkout removeSets:squatWorkout.sets];
    JSet *squatSet = [[JSetStore instance] create];
    squatSet.lift = [[JSSLiftStore instance] find:@"name" value:@"Squat"];
    [squatWorkout addSet:squatSet];
    [[JSSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals((int)[squatWorkout.sets count], 6, @"");
    JSet *firstSet = [squatWorkout.sets firstObject];
    JSet *lastSet = [squatWorkout.sets lastObject];
    STAssertTrue(firstSet.warmup, @"");
    STAssertTrue([firstSet.reps intValue] > 0, @"");
    STAssertEqualObjects([firstSet effectiveWeight], @45, @"");
    STAssertFalse(lastSet.warmup, @"");
}

- (void)testCanRemoveWarmups {
    JSSWorkout *workoutA = [[JSSWorkoutStore instance] find:@"name" value:@"A"];
    JWorkout *squatWorkout = [self findWorkout:workoutA name:@"Squat"];
    [[JSSWarmupGenerator new] addWarmup:squatWorkout];
    STAssertEquals((int)[squatWorkout.sets count], 8, @"");
    [[JSSWarmupGenerator new] removeWarmup:squatWorkout];
    STAssertEquals((int)[squatWorkout.sets count], 3, @"");
}

- (JWorkout *)findWorkout:(JSSWorkout *)workoutA name:(NSString *)name {
    return [workoutA.workouts detect:^BOOL(JWorkout *workout) {
        JSet *set = workout.sets[0];
        return [set.lift.name isEqualToString:name];
    }];
}

@end