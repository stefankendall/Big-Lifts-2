#import "JFTOFullCustomAssistanceTests.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JSet.h"
#import "JFTOFullCustomAssistance.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JFTOAssistanceStore.h"
#import "JFTOAssistance.h"
#import "JFTOSetStore.h"
#import "BLJStoreManager.h"

@implementation JFTOFullCustomAssistanceTests

- (void)testSetsUpFullCustom {
    JFTOFullCustomAssistanceWorkout *workout1 = [[JFTOFullCustomAssistanceWorkoutStore instance] create];
    workout1.week = @1;
    workout1.mainLift = [[JFTOLiftStore instance] find:@"name" value:@"Bench"];
    JSet *set1 = [[JSetStore instance] create];
    set1.reps = @1;
    [workout1.workout addSet:set1];

    JFTOFullCustomAssistanceWorkout *workout2 = [[JFTOFullCustomAssistanceWorkoutStore instance] create];
    workout2.week = @2;
    workout2.mainLift = [[JFTOLiftStore instance] find:@"name" value:@"Bench"];
    JSet *set2 = [[JSetStore instance] create];
    set2.reps = @2;
    [workout2.workout addSet:set2];

    [[JFTOFullCustomAssistance new] setup];
    JFTOWorkout *bench1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    JFTOWorkout *notBench1 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1][1];
    JFTOWorkout *bench2 = [[JFTOWorkoutStore instance] findAllWhere:@"week" value:@2][0];

    STAssertEquals((int) [bench1.workout.assistanceSets count], 1, @"");
    STAssertEquals((int) [notBench1.workout.assistanceSets count], 0, @"");
    STAssertEquals((int) [bench2.workout.assistanceSets count], 1, @"");

    JSet *bench1LastSet = [bench1.workout.sets lastObject];
    JSet *bench2LastSet = [bench2.workout.sets lastObject];

    STAssertEqualObjects(bench1LastSet.reps, @1, @"");
    STAssertEqualObjects(bench2LastSet.reps, @2, @"");
}

- (void)testRemovingFirstCustomLiftDoesNotWipeDataOnLoad {
    JFTOCustomAssistanceLift *lift1 = [[JFTOCustomAssistanceLiftStore instance] create];
    lift1.name = @"Lift 1";

    JFTOCustomAssistanceLift *lift2 = [[JFTOCustomAssistanceLiftStore instance] create];
    lift2.name = @"Lift 2";

    JFTOFullCustomAssistanceWorkout *workout1 = [[JFTOFullCustomAssistanceWorkoutStore instance] first];
    JSet *set1 = [[JSetStore instance] create];
    set1.lift = lift1;
    [workout1.workout addSet:set1];

    JSet *set2 = [[JFTOSetStore instance] create];
    set2.lift = lift2;
    [workout1.workout addSet:set2];

    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_FULL_CUSTOM];

    [[JFTOCustomAssistanceLiftStore instance] removeAtIndex:0];

    [[BLJStoreManager instance] syncStores];
    [[BLJStoreManager instance] loadStores];

    STAssertEquals([[JFTOCustomAssistanceLiftStore instance] count], 1, @"");
    workout1 = [[JFTOFullCustomAssistanceWorkoutStore instance] first];
    STAssertEquals((int) [workout1.workout.sets count], (int) 1, @"");
}

@end