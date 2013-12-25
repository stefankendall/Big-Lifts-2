#import "JFTOCustomAssistanceTests.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"
#import "JWorkout.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JSetStore.h"
#import "JSet.h"
#import "JFTOAssistanceStore.h"
#import "JFTOAssistance.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"

@implementation JFTOCustomAssistanceTests

- (void)testSetsUpCustomAssistance {
    JFTOCustomAssistanceWorkout *customWorkout = [[JFTOCustomAssistanceWorkoutStore instance] create];
    customWorkout.mainLift = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    JFTOCustomAssistanceLift *customLift = [[JFTOCustomAssistanceLiftStore instance] create];
    JSet *set = [[JSetStore instance] create];
    set.lift = customLift;
    set.reps = @5;
    set.percentage = N(100);
    [customWorkout.workout addSet:set];

    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_CUSTOM];
    JFTOWorkout *squatWorkout1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][1];
    JFTOWorkout *benchWorkout = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JFTOWorkout *squatWorkout2 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@2][1];

    STAssertEquals([squatWorkout1.workout.sets count], 7U, @"");
    STAssertEquals([squatWorkout2.workout.sets count], 7U, @"");
    STAssertEquals([benchWorkout.workout.sets count], 6U, @"");

    JSet *lastSet = [squatWorkout1.workout.sets lastObject];
    STAssertEquals(lastSet.assistance, YES, @"");
    STAssertEquals(lastSet.lift, customLift, @"");
}

- (void)testIncrementsLiftsOnCycleChange {
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_CUSTOM];

    JFTOCustomAssistanceLift *lift = [[JFTOCustomAssistanceLiftStore instance] create];
    lift.increment = N(5);
    lift.weight = N(100);
    [[JFTOAssistanceStore instance] cycleChange];
    STAssertEqualObjects(lift.weight, N(105), @"");
}

@end