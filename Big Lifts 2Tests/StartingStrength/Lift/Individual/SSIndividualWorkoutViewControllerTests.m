#import "SSIndividualWorkoutViewControllerTests.h"
#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "SSWorkoutStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLog.h"
#import "SSWorkout.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSStateStore.h"
#import "SSState.h"
#import "IAPAdapter.h"

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
    STAssertEquals([[self.controller individualWorkoutDataSource] workoutIndex], 1, @"");
}

- (void)testLastWorkoutPageHasSaveButton {
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];

    [self.controller nextButtonTapped:nil];
    [self.controller nextButtonTapped:nil];
    NSString *title = [[[self.controller navigationItem] rightBarButtonItem] title];
    STAssertTrue([title isEqualToString:@"Done"], title);
}

- (void)testTappingDoneButtonLogsWorkout {
    [[IAPAdapter instance] addPurchase:@"ssWarmup"];
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];
    [self.controller doneButtonTapped:nil];

    WorkoutLogStore *logStore = [WorkoutLogStore instance];
    WorkoutLog *workoutLog = [logStore first];
    STAssertEquals([logStore count], 1, @"");
    NSOrderedSet *workSets = [workoutLog sets];

    STAssertEquals([workSets count], (NSUInteger) 7, @"");
    STAssertNotNil(workoutLog.date, @"");

    STAssertTrue([((SetLog *) workSets[0]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((SetLog *) workSets[1]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((SetLog *) workSets[2]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((SetLog *) workSets[3]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((SetLog *) workSets[4]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((SetLog *) workSets[5]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((SetLog *) workSets[6]).name isEqualToString:@"Deadlift"], @"");
}

- (void)testTappingDoneButtonWithoutWarmup {
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];
    [self.controller doneButtonTapped:nil];

    WorkoutLogStore *logStore = [WorkoutLogStore instance];
    WorkoutLog *workoutLog = [logStore first];
    STAssertEquals([[workoutLog sets] count], (NSUInteger) 7, @"");
}

- (void)testTappingDoneButtonIncrementsWeights {
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];

    SSLift *squat = [[SSLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    [self.controller doneButtonTapped:nil];
    STAssertEquals([squat.weight intValue], 210, @"");
}

- (void)testTappingDoneButtonSetsState {
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];
    [self.controller doneButtonTapped:nil];
    SSState *state = [[SSStateStore instance] first];
    STAssertEquals(state.lastWorkout, self.controller.ssWorkout, @"");
}

- (void)testChangesWorkoutAAlternationOnAWeeksForOnus {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];
    [self.controller doneButtonTapped:nil];
    SSState *state = [[SSStateStore instance] first];
    STAssertEqualObjects(state.workoutAAlternation, @1, @"");
}

- (void)testDoesNotChangeWorkoutAAlternationOnBWeeksForOnus {
    [[SSWorkoutStore instance] setupVariant:@"Onus-Wunsler"];
    self.controller.ssWorkout = [[SSWorkoutStore instance] find:@"name" value:@"B"];
    [self.controller doneButtonTapped:nil];
    SSState *state = [[SSStateStore instance] first];
    STAssertEqualObjects(state.workoutAAlternation, @0, @"");
}

@end