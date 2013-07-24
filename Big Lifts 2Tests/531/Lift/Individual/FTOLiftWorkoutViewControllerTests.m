#import "FTOLiftWorkoutViewControllerTests.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOLiftWorkoutViewController.h"
#import "Workout.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLog.h"
#import "SetCellWithPlates.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "FTOWorkoutCell.h"

@interface FTOLiftWorkoutViewControllerTests ()

@property(nonatomic) FTOLiftWorkoutViewController *controller;
@property(nonatomic) FTOWorkout *ftoWorkout;
@end

@implementation FTOLiftWorkoutViewControllerTests

- (void)setUp {
    [super setUp];
    self.ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    self.controller = [self getControllerByStoryboardIdentifier:@"ftoLiftWorkout"];
    [self.controller setWorkout:self.ftoWorkout];
}

- (void)testHasWorkoutRows {
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 1 + (NSInteger) [self.ftoWorkout.workout.sets count], @"");
}

- (void)testTappingDoneButtonSavesLog {
    [self.controller doneButtonTapped:nil];

    STAssertEquals([[[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] count], 1U, @"");
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] find:@"name" value:@"5/3/1"];
    STAssertNotNil(workoutLog.date, @"");
    STAssertTrue(self.ftoWorkout.done, @"");
}

- (void)testTappingAmrapCellCausesSegue {
    UINavigationController *nav = [UINavigationController new];
    [nav addChildViewController:self.controller];
    [self.controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    STAssertEquals([self.controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testTappingNonAmrapCellDoesNotCauseSegue {
    UINavigationController *nav = [UINavigationController new];
    [nav addChildViewController:self.controller];
    [self.controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertEquals([self.controller.navigationController.viewControllers count], 1U, @"");
}

- (void)testAmrapRepsCanBeChanged {
    self.controller.tappedSetRow = @6;
    [self.controller repsChanged:@7];
    [self.controller doneButtonTapped:nil];

    WorkoutLog *log = [[WorkoutLogStore instance] first];
    SetLog *lastSet = [[log sets] lastObject];
    STAssertEqualObjects(lastSet.reps, @7, @"");
}

- (void)testUsesPlates {
    [[IAPAdapter instance] addPurchase:IAP_BAR_LOADING];
    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    STAssertTrue([cell.setCell isKindOfClass:SetCellWithPlates.class], @"");
}

- (void)testShowsSetVariableRepsWhenAvailable {
    self.controller.tappedSetRow = @6;
    [self.controller repsChanged:@7];
    [self.controller doneButtonTapped:nil];
    [self.controller viewWillAppear:YES];

    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:6 inSection:0]];

    STAssertEqualObjects([[[cell setCell] repsLabel] text], @"7x", @"");
}

@end