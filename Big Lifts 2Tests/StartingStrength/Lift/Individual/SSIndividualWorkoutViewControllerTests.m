#import "JSet.h"
#import "SSIndividualWorkoutViewControllerTests.h"
#import "SSIndividualWorkoutViewController.h"
#import "JSSWorkoutStore.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "JSSLiftStore.h"
#import "JSSLift.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JSSStateStore.h"
#import "IAPAdapter.h"
#import "SetCellWithPlates.h"
#import "Purchaser.h"
#import "JSSWorkout.h"
#import "JSSState.h"
#import "JWorkout.h"
#import "BLTimer.h"

@interface SSIndividualWorkoutViewControllerTests ()
@property(nonatomic, strong) SSIndividualWorkoutViewController *controller;
@end

@implementation SSIndividualWorkoutViewControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [self getControllerByStoryboardIdentifier:@"ssIndividualWorkout"];
}

- (void)testTappingNextMovesWorkoutForward {
    [self.controller nextButtonTapped:nil];
    STAssertEquals([self.controller workoutIndex], 1, @"");
}

- (void)testLastWorkoutPageHasSaveButton {
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];

    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    NSString *title = [[[self.controller navigationItem] rightBarButtonItem] title];
    STAssertTrue([title isEqualToString:@"Done"], title);
}

- (void)testTappingDoneButtonLogsWorkout {
    [[IAPAdapter instance] addPurchase:IAP_SS_WARMUP];
    [[JSSWorkoutStore instance] addWarmup];
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];

    JWorkoutLogStore *logStore = [JWorkoutLogStore instance];
    JWorkoutLog *workoutLog = [logStore first];
    STAssertEquals([logStore count], 1, @"");
    NSArray *workSets = [workoutLog sets];

    STAssertEquals([workSets count], (NSUInteger) 7, @"");
    STAssertNotNil(workoutLog.date, @"");

    JSetLog *log1 = (JSetLog *) workSets[0];
    STAssertFalse(log1.warmup, @"");
    STAssertTrue([log1.name isEqualToString:@"Squat"], @"");
    STAssertTrue([((JSetLog *) workSets[1]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((JSetLog *) workSets[2]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((JSetLog *) workSets[3]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((JSetLog *) workSets[4]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((JSetLog *) workSets[5]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((JSetLog *) workSets[6]).name isEqualToString:@"Deadlift"], @"");
}

- (void)testTappingDoneButtonWithoutWarmup {
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];

    JWorkoutLogStore *logStore = [JWorkoutLogStore instance];
    JWorkoutLog *workoutLog = [logStore first];
    STAssertEquals([[workoutLog sets] count], (NSUInteger) 7, @"");
}

- (void)testTappingDoneButtonIncrementsWeights {
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];

    JSSLift *squat = [[JSSLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];
    STAssertEquals([squat.weight intValue], 210, @"");
}

- (void)testTappingDoneButtonSetsState {
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];
    JSSState *state = [[JSSStateStore instance] first];
    STAssertEquals(state.lastWorkout, self.controller.ssWorkout, @"");
}

- (void)testChangesWorkoutAAlternationOnAWeeksForOnus {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];
    JSSState *state = [[JSSStateStore instance] first];
    STAssertEqualObjects(state.workoutAAlternation, @1, @"");
}

- (void)testDoesNotChangeWorkoutAAlternationOnBWeeksForOnus {
    [[JSSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    self.controller.ssWorkout = [[JSSWorkoutStore instance] find:@"name" value:@"B"];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];
    JSSState *state = [[JSSStateStore instance] first];
    STAssertEqualObjects(state.workoutAAlternation, @0, @"");
}

- (void)testDoesNotShow100OnLastSet {
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];
    int rows = [self.controller tableView:self.controller.tableView numberOfRowsInSection:1];
    SetCell *cell = (SetCell *) [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(rows - 1, 1)];
    STAssertEqualObjects([cell.percentageLabel text], @"100%", @"");
    STAssertTrue([cell.percentageLabel isHidden], @"");
}

- (void)testReturnsCorrectNumberOfRowsWithWarmup {
    [[IAPAdapter instance] addPurchase:IAP_SS_WARMUP];
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    JWorkout *workout = ssWorkout.workouts[0];
    self.controller.ssWorkout = ssWorkout;
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:1], (int) [workout.sets count], @"");
}

- (void)testReturnsCorrectNumberOfRowsWithoutWarmup {
    self.controller.ssWorkout = [[JSSWorkoutStore instance] first];
    STAssertEquals((int) [self.controller tableView:nil numberOfRowsInSection:1], 3, @"");
}

- (void)testReturnsPlatesWhenBarLoadingPurchased {
    [[IAPAdapter instance] addPurchase:IAP_BAR_LOADING];
    UITableViewCell *cell = [self.controller tableView:nil cellForRowAtIndexPath:NSIP(0, 1)];
    STAssertTrue([cell isKindOfClass:SetCellWithPlates.class], @"");
}

- (void)testNoPlatesWhenBarLoadingUnpurchased {
    UITableViewCell *cell = [self.controller tableView:nil cellForRowAtIndexPath:NSIP(0, 1)];
    STAssertFalse([cell isKindOfClass:SetCellWithPlates.class], @"");
}

- (void)testCanChangeLoggedReps {
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    self.controller.ssWorkout = ssWorkout;
    self.controller.tappedSet = [ssWorkout.workouts[0] sets][0];
    [self.controller repsChanged:@7];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];

    JWorkoutLog *log = [[JWorkoutLogStore instance] first];
    JSetLog *firstSet = log.sets[0];
    STAssertEqualObjects(firstSet.reps, @7, @"");
}

- (void)testCanChangeLoggedWeight {
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    self.controller.ssWorkout = ssWorkout;
    self.controller.tappedSet = [ssWorkout.workouts[0] sets][0];
    [self.controller weightChanged:N(200)];
    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    [self.controller doneButtonTapped:nil];

    JWorkoutLog *log = [[JWorkoutLogStore instance] first];
    JSetLog *firstSet = log.sets[0];
    STAssertEqualObjects(firstSet.weight, N(200), @"");
}

- (void)testWeightChangesAppearInWorkout {
    JSSWorkout *ssWorkout = [[JSSWorkoutStore instance] first];
    self.controller.ssWorkout = ssWorkout;
    self.controller.tappedSet = [ssWorkout.workouts[0] sets][0];
    self.controller.tappedIndexPath = NSIP(0,1);
    [self.controller repsChanged:N(1)];
    SetCell *changedCell = [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(0,1)];
    SetCell *notChangedCell = [self.controller tableView:self.controller.tableView cellForRowAtIndexPath:NSIP(1,1)];

    STAssertEqualObjects([changedCell.repsLabel text], @"1x", @"");
    STAssertEqualObjects([notChangedCell.repsLabel text], @"5x", @"");
}

- (void)testSetsTimerObserver {
    STAssertEquals([[BLTimer instance] observer], self.controller, @"");
}

@end