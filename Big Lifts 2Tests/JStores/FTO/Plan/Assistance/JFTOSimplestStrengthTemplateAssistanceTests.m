#import "JWorkout.h"
#import "NSArray+Enumerable.h"
#import "JFTOSimplestStrengthTemplateAssistanceTests.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JFTOSSTLiftStore.h"
#import "JFTOSimplestStrengthTemplateAssistance.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "JFTOSSTLift.h"
#import "JSet.h"

@implementation JFTOSimplestStrengthTemplateAssistanceTests

- (void)testSetsUpWeekPercentages {
    [[JFTOSimplestStrengthTemplateAssistance new] setup];
    JFTOWorkout *week1Workout = [self findWorkout:1 withLift:@"Squat"];
    STAssertEquals([week1Workout.workout.orderedSets count], 9U, @"");
    JSet *lastSet = week1Workout.workout.orderedSets[8];
    STAssertEquals([lastSet.reps intValue], 10, @"");
    STAssertEqualObjects(lastSet.percentage, N(70), @"");
}

- (void)testIncrementsOnCycleChange {
    [[JFTOSimplestStrengthTemplateAssistance new] setup];
    JFTOSSTLift *lift = [[JFTOSSTLiftStore instance] find:@"name" value:@"Front Squat"];
    NSDecimalNumber *weight = [lift.weight copy];

    [[JFTOSimplestStrengthTemplateAssistance new] cycleChange];
    STAssertEqualObjects([weight decimalNumberByAdding:N(10)], lift.weight, @"");
}

- (void) testHandlesLiftRenames {
    JFTOLift *squat = [[JFTOLiftStore instance] find: @"name" value: @"Squat"];
    squat.name = @"Front Squat";
    [[JFTOSimplestStrengthTemplateAssistance new] setup];

    JFTOWorkout *week1Workout = [self findWorkout:1 withLift:@"Front Squat"];
    STAssertEquals([week1Workout.workout.orderedSets count], 9U, @"");
    STAssertEquals([[JFTOSSTLiftStore instance] count], 4, @"");
}

- (JFTOWorkout *)findWorkout:(int)week withLift:(NSString *)liftName {
    return [[[JFTOWorkoutStore instance] findAll] detect:^BOOL(JFTOWorkout *workout) {
        return [workout.week intValue] == week && [[workout.workout.orderedSets[0] lift].name isEqualToString:liftName];
    }];
}

@end