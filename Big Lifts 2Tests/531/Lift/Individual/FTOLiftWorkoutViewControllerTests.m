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
#import "FTOVariantStore.h"
#import "FTOVariant.h"

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
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:1], (NSInteger) [self.ftoWorkout.workout.sets count], @"");
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 1, @"");
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
    [self.controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
    STAssertEquals([self.controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testTappingNonAmrapCellDoesNotCauseSegue {
    UINavigationController *nav = [UINavigationController new];
    [nav addChildViewController:self.controller];
    [self.controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEquals([self.controller.navigationController.viewControllers count], 1U, @"");
}

- (void)testAmrapRepsCanBeChanged {
    self.controller.tappedSetRow = @5;
    [self.controller repsChanged:@7];
    [self.controller doneButtonTapped:nil];

    WorkoutLog *log = [[WorkoutLogStore instance] first];
    SetLog *lastSet = [[log sets] lastObject];
    STAssertEqualObjects(lastSet.reps, @7, @"");
}

- (void)testUsesPlates {
    [[IAPAdapter instance] addPurchase:IAP_BAR_LOADING];
    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    STAssertTrue([cell.setCell isKindOfClass:SetCellWithPlates.class], @"");
}

- (void)testShowsSetVariableRepsWhenAvailable {
    self.controller.tappedSetRow = @5;
    [self.controller repsChanged:@7];
    [self.controller doneButtonTapped:nil];
    [self.controller viewWillAppear:YES];

    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:5 inSection:1]];

    STAssertEqualObjects([[[cell setCell] repsLabel] text], @"7x", @"");
}

- (void)testChoosesHeaviestAmrapSetForRepsToBeat {
    [[FTOVariantStore instance] changeTo:FTO_VARIANT_PYRAMID];
    self.ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    Set *heaviestAmrapSet = [self.controller heaviestAmrapSet:self.ftoWorkout.workout.sets];
    STAssertEquals([self.ftoWorkout.workout.sets indexOfObject:heaviestAmrapSet], 5U, @"");
}

- (void)testDeterminesIfMissedReps {
    self.ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    [self.controller setWorkout:self.ftoWorkout];
    [self.controller setVariableReps:[@{@5: @4} mutableCopy]];
    STAssertTrue([self.controller missedAmrapReps], @"");
}

- (void)testDeterminesIfMissedRepsNoFailure {
    self.ftoWorkout = [[[FTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    [self.controller setWorkout:self.ftoWorkout];
    [self.controller setVariableReps:[@{@5: @5} mutableCopy]];
    STAssertFalse([self.controller missedAmrapReps], @"");
}

@end