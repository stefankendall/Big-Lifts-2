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
#import "JFTOAssistanceStore.h"
#import "SetHelper.h"
#import "JWorkout.h"
#import "JFTOVariant.h"
#import "JSet.h"
#import "JFTOAssistance.h"
#import "SetChange.h"
#import "FTOWorkoutChangeCache.h"

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
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:0], 1, @"");
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:1], 3, @"");
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:2], 3, @"");

    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    self.controller.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:3], 5, @"");
}

- (void)testHasSectionTitles {
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:0], @"", @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:1], @"Warm-up", @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:2], @"Workout", @"");
    [[JFTOAssistanceStore instance] changeTo:FTO_ASSISTANCE_BORING_BUT_BIG];
    self.controller.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:3], @"Assistance", @"");
}

- (void)testTappingDoneButtonSavesLog {
    [self.controller doneButtonTapped:nil];

    STAssertEquals((int) [[[JWorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] count], 1, @"");
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] find:@"name" value:@"5/3/1"];
    STAssertNotNil(workoutLog.date, @"");
    STAssertTrue(self.ftoWorkout.done, @"");
}

- (void)testDoesNotSave0RepsInLog {
    self.controller.tappedSetRow = @0;
    [self.controller repsChanged:@0];
    [self.controller doneButtonTapped:nil];
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] find:@"name" value:@"5/3/1"];
    STAssertEquals((int) [workoutLog.sets count], 5, @"");
}

- (void)testTappingAmrapCellCausesSegue {
    UINavigationController *nav = [UINavigationController new];
    [nav addChildViewController:self.controller];
    [self.controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
    STAssertEquals((int) [self.controller.navigationController.viewControllers count], 2, @"");
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
    [self.controller viewWillAppear:YES];

    FTOWorkoutCell *cell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(5,1)];
    FTOWorkoutCell *firstCell = (FTOWorkoutCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(0,1)];

    STAssertEqualObjects([[[cell setCell] repsLabel] text], @"7x", @"");
    STAssertFalse([[[[firstCell setCell] repsLabel] text] isEqualToString:@"7x"], @"");
}

- (void)testChoosesHeaviestAmrapSetForRepsToBeat {
    [[JFTOVariantStore instance] changeTo:FTO_VARIANT_PYRAMID];
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    JSet *heaviestAmrapSet = [SetHelper heaviestAmrapSet:self.ftoWorkout.workout.sets];
    STAssertEquals((int) [self.ftoWorkout.workout.sets indexOfObject:heaviestAmrapSet], 5, @"");
}

- (void)testDeterminesIfMissedReps {
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    [self.controller setWorkout:self.ftoWorkout];
    SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:5];
    setChange.reps = @4;
    STAssertTrue([self.controller missedAmrapReps], @"");
}

- (void)testDeterminesIfMissedRepsNoFailure {
    self.ftoWorkout = [[[JFTOWorkoutStore instance] findAllWhere:@"week" value:@1] firstObject];
    [self.controller setWorkout:self.ftoWorkout];
    SetChange *setChange = [[FTOWorkoutChangeCache instance] changeForWorkout:self.ftoWorkout set:5];
    setChange.reps = @5;
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
    NSArray *warmupSets = [self.ftoWorkout.workout.sets select:^BOOL(JSet *set) {
        return set.warmup;
    }];
    [self.ftoWorkout.workout removeSets:warmupSets];
    int sections = [self.controller numberOfSectionsInTableView:self.controller.tableView];
    STAssertEquals((int) [self.controller tableView:self.controller.tableView numberOfRowsInSection:0], 1, @"");
    STAssertEquals((int) [self.controller tableView:self.controller.tableView numberOfRowsInSection:1], 3, @"");
    STAssertEquals(sections, 2, @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:0], @"", @"");
    STAssertEqualObjects([self.controller tableView:self.controller.tableView titleForHeaderInSection:1], @"Workout", @"");
}

- (void)testWeightChangedNilWeightDoesntCrash {
    self.controller.tappedSetRow = @0;
    [self.controller weightChanged:nil];
}

@end