#import "FTOWorkoutStoreTests.h"
#import "BLStore.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "FTOSet.h"

@implementation FTOWorkoutStoreTests

- (void)testSetsUpDefaultWorkouts {
    NSArray *ftoWorkouts = [[FTOWorkoutStore instance] findAll];
    STAssertEquals( [ftoWorkouts count], 16U, @"");

    NSArray *liftNames = [ftoWorkouts collect:^NSString *(FTOWorkout *ftoWorkout) {
        Set *firstSet = ftoWorkout.workout.sets[0];
        return firstSet.lift.name;
    }];

    STAssertTrue([liftNames containsObject:@"Bench"], @"");
    STAssertTrue([liftNames containsObject:@"Press"], @"");
    STAssertTrue([liftNames containsObject:@"Deadlift"], @"");
    STAssertTrue([liftNames containsObject:@"Squat"], @"");

    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertTrue([ftoWorkout.workout.sets[0] isKindOfClass:FTOSet.class], @"");
    FTOSet *lastSet = [ftoWorkout.workout.sets lastObject];
    STAssertTrue(lastSet.amrap, @"");
}

@end