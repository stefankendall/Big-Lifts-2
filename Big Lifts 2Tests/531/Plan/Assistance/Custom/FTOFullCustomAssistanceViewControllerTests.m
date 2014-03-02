#import "FTOFullCustomAssistanceViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOFullCustomAssistanceViewController.h"
#import "JFTOCustomComplexAssistanceWorkout.h"

@implementation FTOFullCustomAssistanceViewControllerTests

- (void)testHasSectionsForEachWeek {
    FTOFullCustomAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomAsst"];
    STAssertEquals((int) [controller numberOfSectionsInTableView:controller.tableView], 5, @"");
}

- (void)testHasSectionTitles {
    FTOFullCustomAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomAsst"];
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:0], @"", @"");
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:1], @"5/5/5", @"");
}

- (void)testFindsCorrectAssistanceWorkout {
    FTOFullCustomAssistanceViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoFullCustomAsst"];
    JFTOCustomComplexAssistanceWorkout *workout1 = [controller customAssistanceWorkoutForIndexPath:NSIP(0, 1)];
    STAssertEqualObjects(workout1.week, @1, @"");

    JFTOCustomComplexAssistanceWorkout *workout2 = [controller customAssistanceWorkoutForIndexPath:NSIP(0, 2)];
    STAssertEqualObjects(workout2.week, @2, @"");

    JFTOCustomComplexAssistanceWorkout *workout3 = [controller customAssistanceWorkoutForIndexPath:NSIP(0, 3)];
    STAssertEqualObjects(workout3.week, @3, @"");

    JFTOCustomComplexAssistanceWorkout *workout4 = [controller customAssistanceWorkoutForIndexPath:NSIP(0, 4)];
    STAssertEqualObjects(workout4.week, @4, @"");
}

@end