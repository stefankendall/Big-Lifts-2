#import "SSIndividualWorkoutViewControllerTests.h"
#import "SSIndividualWorkoutViewController.h"
#import "SSIndividualWorkoutDataSource.h"
#import "BLStoreManager.h"
#import "SSWorkoutStore.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLog.h"
#import "SSWorkout.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation SSIndividualWorkoutViewControllerTests
@synthesize controller;

- (void)setUp {
    [super setUp];

    controller = [SSIndividualWorkoutViewController new];
    [controller viewDidLoad];
}

- (void)testTappingNextMovesWorkoutForward {
    [controller nextButtonTapped:nil];
    STAssertEquals([controller workoutIndex], 1, @"");
    STAssertEquals([[controller individualWorkoutDataSource] workoutIndex], 1, @"");
}

- (void)testLastWorkoutPageHasSaveButton {
    controller.ssWorkout = [[SSWorkoutStore instance] first];

    [controller nextButtonTapped:nil];
    [controller nextButtonTapped:nil];
    NSString *title = [[[controller navigationItem] rightBarButtonItem] title];
    STAssertTrue([title isEqualToString:@"Done"], title);
}

- (void)testTappingDoneButtonLogsWorkout {
    controller.ssWorkout = [[SSWorkoutStore instance] first];
    [controller doneButtonTapped:nil];

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
    SSLift *squat = [[SSLiftStore instance] find:@"name" value:@"Squat"];
    squat.weight = [NSNumber numberWithFloat:200.0];
    [controller doneButtonTapped:nil];
    STAssertEquals(squat.weight, 210.0, @"");
}

@end