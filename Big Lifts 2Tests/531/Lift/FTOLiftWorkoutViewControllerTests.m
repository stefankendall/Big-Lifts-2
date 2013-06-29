#import "FTOLiftWorkoutViewControllerTests.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOLiftWorkoutViewController.h"
#import "Workout.h"

@implementation FTOLiftWorkoutViewControllerTests

- (void)testHasWorkoutRows {
    FTOWorkout *ftoWorkout = [[FTOWorkoutStore instance] first];
    FTOLiftWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLiftWorkout"];
    controller.ftoWorkout = ftoWorkout;
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], (NSInteger) [ftoWorkout.workout.sets count], @"");
}

@end