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
#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"

@implementation JFTOSimplestStrengthTemplateAssistanceTests

- (void)testSetsUpWeekPercentages {
    [[JFTOSimplestStrengthTemplateAssistance new] setup];
    JFTOWorkout *week1Workout = [self findWorkout:1 withLift:@"Squat"];
    STAssertEquals((int) [week1Workout.workout.sets count], 9, @"");
    JSet *lastSet = week1Workout.workout.sets[8];
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

- (void)testHandlesLiftRenames {
    JFTOLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    squat.name = @"Front Squat";
    [[JFTOSimplestStrengthTemplateAssistance new] setup];

    JFTOWorkout *week1Workout = [self findWorkout:1 withLift:@"Front Squat"];
    STAssertEquals((int) [week1Workout.workout.sets count], 9, @"");
    STAssertEquals([[JFTOSSTLiftStore instance] count], 4, @"");
}

- (void)testSetsUpSixWeek {
    [[[JFTOSettingsStore instance] first] setSixWeekEnabled:YES];
    [[JFTOWorkoutStore instance] switchTemplate];

    [[JFTOSimplestStrengthTemplateAssistance new] setup];
    JFTOWorkout *week5Workout = [self findWorkout:5 withLift:@"Squat"];
    STAssertEquals((int) [week5Workout.workout.sets count], 9, @"");
}

- (JFTOWorkout *)findWorkout:(int)week withLift:(NSString *)liftName {
    return [[[JFTOWorkoutStore instance] findAll] detect:^BOOL(JFTOWorkout *workout) {
        return [workout.week intValue] == week && [[workout.workout.sets[0] lift].name isEqualToString:liftName];
    }];
}

@end