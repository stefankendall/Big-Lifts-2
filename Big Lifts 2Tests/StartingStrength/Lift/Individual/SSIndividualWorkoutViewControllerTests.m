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
    self.controller.ssWorkout = [[SSWorkoutStore instance] first];
    [self.controller doneButtonTapped:nil];

    WorkoutLogStore *logStore = [WorkoutLogStore instance];
    WorkoutLog *workoutLog = [logStore first];
    STAssertEquals([logStore count], 1, @"");
    STAssertEquals([[workoutLog sets] count], (NSUInteger) 7, @"");
    STAssertNotNil(workoutLog.date, @"");

    STAssertTrue([((SetLog *) [workoutLog sets][0]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((SetLog *) [workoutLog sets][1]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((SetLog *) [workoutLog sets][2]).name isEqualToString:@"Squat"], @"");
    STAssertTrue([((SetLog *) [workoutLog sets][3]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((SetLog *) [workoutLog sets][4]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((SetLog *) [workoutLog sets][5]).name isEqualToString:@"Bench"], @"");
    STAssertTrue([((SetLog *) [workoutLog sets][6]).name isEqualToString:@"Deadlift"], @"");
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

@end