#import "FTOLiftWorkoutViewControllerTests.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOLiftWorkoutViewController.h"
#import "Workout.h"
#import "WorkoutLogStore.h"
#import "FTOLiftWorkoutToolbar.h"
#import "WorkoutLog.h"
#import "SetLog.h"

@interface FTOLiftWorkoutViewControllerTests ()

@property(nonatomic) FTOLiftWorkoutViewController *controller;
@property(nonatomic) FTOWorkout *ftoWorkout;
@end

@implementation FTOLiftWorkoutViewControllerTests

- (void)setUp {
    [super setUp];
    self.ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    self.controller = [self getControllerByStoryboardIdentifier:@"ftoLiftWorkout"];
    self.controller.ftoWorkout = self.ftoWorkout;
}

- (void)testHasWorkoutRows {
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 1 + (NSInteger) [self.ftoWorkout.workout.sets count], @"");
}

- (void)testTappingDoneButtonSavesLog {
    [self.controller doneButtonTapped:nil];

    STAssertEquals([[[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] count], 1U, @"");
    STAssertTrue(self.ftoWorkout.done, @"");
}

- (void)testRepsPlaceHolderIsWorkoutReps {
    FTOLiftWorkoutToolbar *toolbar = (FTOLiftWorkoutToolbar *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([toolbar.repsField placeholder], @"5", @"");
}

- (void)testSavesEnteredReps {
    FTOLiftWorkoutToolbar *toolbar = (FTOLiftWorkoutToolbar *) [self.controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [toolbar.repsField setText:@"7"];
    [self.controller textFieldDidEndEditing:toolbar.repsField];
    [self.controller doneButtonTapped:nil];
    WorkoutLog *log = [[WorkoutLogStore instance] find:@"name" value:@"5/3/1"];
    SetLog *set = [log.sets lastObject];
    STAssertEqualObjects(set.reps, @7, @"");
}

@end