#import "Migrate18to19Tests.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "Migrate16to17.h"
#import "Migrate18to19.h"

@implementation Migrate18to19Tests

- (void)testRemovesInvalidCustomAssistanceWorkouts {
    JFTOCustomAssistanceWorkout *customAssistanceWorkout = [[JFTOCustomAssistanceWorkoutStore instance] first];
    customAssistanceWorkout.mainLift = nil;
    [[JFTOCustomAssistanceWorkoutStore instance] sync];
    [[Migrate18to19 new] run];
    [[JFTOCustomAssistanceWorkoutStore instance] load];
    STAssertEquals([[JFTOCustomAssistanceWorkoutStore instance] count], 3, @"");
}

@end