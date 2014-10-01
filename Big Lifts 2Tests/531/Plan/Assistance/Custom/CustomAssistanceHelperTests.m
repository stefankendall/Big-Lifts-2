#import "CustomAssistanceHelperTests.h"
#import "CustomAssistanceHelper.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JFTOSetStore.h"

@implementation CustomAssistanceHelperTests

- (void)testAddsBothRegularAndFtoSetsToWorkout {
    JFTOWorkout *jftoWorkout = [[JFTOWorkoutStore instance] first];
    JWorkout *workout = [[JWorkoutStore instance] create];
    [workout addSet:[[JSetStore instance] create]];
    [workout addSet:[[JFTOSetStore instance] create]];
    [workout addSet:[[JSetStore instance] create]];
    [workout addSet:[[JFTOSetStore instance] create]];
    [CustomAssistanceHelper addAssistanceToWorkout:jftoWorkout withAssistance:workout];
    STAssertEquals((int) [[jftoWorkout.workout assistanceSets] count], 4, @"");
}

@end