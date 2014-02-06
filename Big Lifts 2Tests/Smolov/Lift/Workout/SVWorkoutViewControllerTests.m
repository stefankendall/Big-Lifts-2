#import "SVWorkoutViewControllerTests.h"
#import "JSVWorkoutStore.h"
#import "JSVWorkout.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SVWorkoutViewController.h"
#import "NSArray+Enumerable.h"
#import "PaddingTextField.h"
#import "JSVLift.h"
#import "JSVLiftStore.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "SetCell.h"

@implementation SVWorkoutViewControllerTests

- (void)testHandles1RmDays {
    JSVWorkout *svWorkout = [[JSVWorkoutStore instance] create];
    svWorkout.testMax = YES;

    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    [controller setSvWorkout:svWorkout];

    STAssertEquals((int)[controller tableView:controller.tableView numberOfRowsInSection:1], 1, @"");
}

- (void)testMarksWorkoutsComplete {
    JSVWorkout *svWorkout = [[JSVWorkoutStore instance] first];
    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    [controller setSvWorkout:svWorkout];
    [controller doneButtonTapped:nil];
    STAssertTrue(svWorkout.done, @"");
}

- (void)testUpdatesOneRepMaxOnMaxTestDay {
    NSArray *cycle2Workouts = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:@2];
    JSVWorkout *week4MaxTest = [cycle2Workouts detect:^BOOL(JSVWorkout *svWorkout) {
        return [svWorkout.week intValue] == 4;
    }];
    STAssertTrue(week4MaxTest.testMax, @"");
    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    controller.svWorkout = week4MaxTest;
    [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 1)];
    [controller.oneRepField setText:@"300"];
    [controller doneButtonTapped:nil];
    JSVLift *svLift = [[JSVLiftStore instance] first];
    STAssertEqualObjects(svLift.weight, N(300), @"");
}

- (void)testLogsLiftOnMaxDay {
    NSArray *cycle2Workouts = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:@2];
    JSVWorkout *week4MaxTest = [cycle2Workouts detect:^BOOL(JSVWorkout *svWorkout) {
        return [svWorkout.week intValue] == 4;
    }];
    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    controller.svWorkout = week4MaxTest;

    [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 1)];
    [controller.oneRepField setText:@"300"];
    [controller doneButtonTapped:nil];

    NSArray *smolovLogs = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov"];
    STAssertEquals((int)[smolovLogs count], 1, @"");

    JWorkoutLog *workoutLog = smolovLogs[0];
    STAssertNotNil(workoutLog.date, @"");
    STAssertEquals((int)[workoutLog.sets count], 1, @"");

    JSetLog *setLog = workoutLog.sets[0];
    STAssertEqualObjects(setLog.reps, @1, @"");
    STAssertEqualObjects(setLog.weight, N(300), @"");
}

- (void)testLogsLiftsOnNormalLiftDay {
    JSVWorkout *firstWorkout = [[JSVWorkoutStore instance] first];
    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    controller.svWorkout = firstWorkout;

    [controller doneButtonTapped:nil];
    NSArray *smolovLogs = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov"];
    STAssertEquals((int)[smolovLogs count], 1, @"");
    JWorkoutLog *workoutLog = smolovLogs[0];
    STAssertEquals((int)[workoutLog.sets count], 7, @"");
}

- (void)testAddsWeightAdd {
    JSVWorkout *cycle2week2day1 = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:@2][4];
    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    controller.svWorkout = cycle2week2day1;

    [[[JSVLiftStore instance] first] setWeight:N(100)];

    SetCell *cell = (SetCell *) [controller tableView:controller.tableView cellForRowAtIndexPath:NSIP(0, 1)];
    STAssertEqualObjects([cell.weightLabel text], @"90", @"");
}

- (void)testLogsWeightAddWeight {
    JSVWorkout *cycle2week2day1 = [[JSVWorkoutStore instance] findAllWhere:@"cycle" value:@2][4];
    SVWorkoutViewController *controller = [self getControllerByStoryboardIdentifier:@"svWorkout"];
    controller.svWorkout = cycle2week2day1;

    [[[JSVLiftStore instance] first] setWeight:N(100)];
    [[[JSVLiftStore instance] first] setName:@"Squat"];
    [controller doneButtonTapped:nil];

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] findAllWhere:@"name" value:@"Smolov"][0];
    JSetLog *setLog = workoutLog.sets[0];
    STAssertEqualObjects(setLog.reps, @9, @"");
    STAssertEqualObjects(setLog.weight, N(90), @"");
}

@end