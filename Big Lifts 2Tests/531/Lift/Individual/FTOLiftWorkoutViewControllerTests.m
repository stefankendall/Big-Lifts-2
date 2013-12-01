#import "JFTOWorkout.h"
#import "JSetLog.h"
#import "FTOLiftWorkoutViewControllerTests.h"
#import "JFTOWorkoutStore.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOLiftWorkoutViewController.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "SetCellWithPlates.h"
#import "IAPAdapter.h"
#import "Purchaser.h"
#import "FTOWorkoutCell.h"
#import "JFTOVariantStore.h"
#import "NSArray+Enumerable.h"
#import "Set.h"
#import "FTOAssistanceStore.h"
#import "FTOAssistance.h"
#import "SetHelper.h"
#import "JWorkout.h"
#import "JFTOVariant.h"

@interface FTOLiftWorkoutViewControllerTests ()

@property(nonatomic) FTOLiftWorkoutViewController *controller;
@property(nonatomic) JFTOWorkout *ftoWorkout;
@end

@implementation FTOLiftWorkoutViewControllerTests

- (void)setUp {
    [super setUp];
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    self.controller = [self getControllerByStoryboardIdentifier:@"ftoLiftWorkout"];
    [self.controller setWorkout:self.ftoWorkout];
}

- (void)testHasWorkoutRows {
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:0], 1, @"");
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:1], 3, @"");
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:2], 3, @"");

    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    self.controller.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEquals([self.controller tableView:nil numberOfRowsInSection:2], 5, @"");
}

- (void)testHasSectionTitles {
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:0], @"", @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:1], @"Warm-up", @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:2], @"Workout", @"");
    [[FTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    self.controller.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:2], @"Assistance", @"");
}

- (void)testTappingDoneButtonSavesLog {
    [self.controller doneButtonTapped:nil];

    STAssertEquals([[[JWorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] count], 1U, @"");
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] find:@"name" value:@"5/3/1"];
    STAssertNotNil(workoutLog.date, @"");
    STAssertTrue(self.ftoWorkout.done, @"");
}

- (void)testDoesNotSave0RepsInLog {
    self.controller.tappedSetRow = @0;
    [self.controller repsChanged:@0];
    [self.controller doneButtonTapped:nil];
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] find:@"name" value:@"5/3/1"];
    STAssertEquals([workoutLog.orderedSets count], 5U, @"");
}

- (void)testTappingAmrapCellCausesSegue {
    UINavigationController *nav = [UINavigationController new];
    [nav addChildViewController:self.controller];
    [self.controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
    STAssertEquals([self.controller.navigationController.viewControllers count], 2U, @"");
}

- (void)testAmrapRepsCanBeChanged {
    self.controller.tappedSetRow = @5;
    [self.controller repsChanged:@7];
    [self.controller doneButtonTapped:nil];

    JWorkoutLog *log = [[JWorkoutLogStore instance] first];
    JSetLog *lastSet = [[log sets] lastObject];
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
    [[JFTOVariantStore instance] changeTo:FTO_VARIANT_PYRAMID];
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    Set *heaviestAmrapSet = [[SetHelper new] heaviestAmrapSet:self.ftoWorkout.workout.orderedSets];
    STAssertEquals([self.ftoWorkout.workout.orderedSets indexOfObject:heaviestAmrapSet], 5U, @"");
}

- (void)testDeterminesIfMissedReps {
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    [self.controller setWorkout:self.ftoWorkout];
    [self.controller setVariableReps:[@{@5 : @4} mutableCopy]];
    STAssertTrue([self.controller missedAmrapReps], @"");
}

- (void)testDeterminesIfMissedRepsNoFailure {
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    [self.controller setWorkout:self.ftoWorkout];
    [self.controller setVariableReps:[@{@5 : @5} mutableCopy]];
    STAssertFalse([self.controller missedAmrapReps], @"");
}

- (void)testAllowsReadyToBeUnchecked {
    [self.ftoWorkout setDone:YES];
    [self.controller viewWillAppear:YES];

    STAssertEqualObjects([self.controller.doneButton title], @"Not Done", @"");
    [self.controller doneButtonTapped:self.controller.doneButton];
    STAssertFalse(self.ftoWorkout.done, @"");
}

- (void)testHidesWarmupSectionIfNoWarmup {
    NSArray *warmupSets = [self.ftoWorkout.workout.orderedSets select:^BOOL(Set *set) {
        return set.warmup;
    }];
    [self.ftoWorkout.workout removeSets:warmupSets];
    int sections = [self.controller numberOfSectionsInTableView:self.controller.tableView];
    STAssertEquals([self.controller tableView:self.controller.tableView numberOfRowsInSection:0], 1, @"");
    STAssertEquals([self.controller tableView:self.controller.tableView numberOfRowsInSection:1], 3, @"");
    STAssertEquals(sections, 2, @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:0], @"", @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:1], @"Workout", @"");
}

- (void)testWeightChangedNilWeightDoesntCrash {
    self.controller.tappedSetRow = @0;
    [self.controller weightChanged:nil];
}

@end