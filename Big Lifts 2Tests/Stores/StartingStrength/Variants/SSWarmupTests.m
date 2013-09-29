#import "SSWarmupTests.h"
#import "SSWarmup.h"
#import "SSWorkoutStore.h"
#import "Workout.h"
#import "SSWorkout.h"
#import "NSArray+Enumerable.h"
#import "SetData.h"
#import "Lift.h"

@implementation SSWarmupTests

- (void)testAddsWarmupSetsForAllLifts {
    Workout *deadlift = [self workoutFor:@"Deadlift" inWeek:@"A"];
    Workout *squat = [self workoutFor:@"Squat" inWeek:@"A"];
    STAssertEquals( [deadlift.sets count], 1U, @"");
    STAssertEquals( [squat.sets count], 3U, @"");
    [[SSWarmup new] addWarmup];
    STAssertEquals( [deadlift.sets count], 5U, @"");
    STAssertEquals( [squat.sets count], 8U, @"");
}

- (Workout *)workoutFor:(NSString *)lift inWeek:(NSString *)week {
    SSWorkout *ssWorkout = [[SSWorkoutStore instance] find:@"name" value:week];
    return [[ssWorkout.workouts array] detect:^BOOL(Workout *w) {
        NSString *liftName = [[[w.sets firstObject] lift] name];
        return [liftName isEqualToString:lift];
    }];
}

@end