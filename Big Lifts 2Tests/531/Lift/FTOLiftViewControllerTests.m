#import "FTOLiftViewControllerTests.h"
#import "FTOLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JFTOVariantStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOVariant.h"

@implementation FTOLiftViewControllerTests

- (void)testHasRowsForEachWeek {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
    STAssertEquals([controller numberOfSectionsInTableView:nil], 4, @"");
}

- (void)testHasLiftNamesInCells {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([[cell textLabel] text], @"Bench", @"");
}

- (void)testHasSectionsForSixWeek {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_SIX_WEEK];
    [[JFTOWorkoutStore instance] switchTemplate];

    STAssertEquals([controller numberOfSectionsInTableView:nil], 7, @"");
    STAssertEqualObjects([controller tableView:nil titleForHeaderInSection:3], @"5/5/5", @"");
    STAssertEqualObjects([controller tableView:nil titleForHeaderInSection:6], @"Deload", @"");
}

- (void)testUsesPlanWeekNames {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    [[[JFTOVariantStore instance] first] setName:FTO_VARIANT_POWERLIFTING];
    [[JFTOWorkoutStore instance] switchTemplate];
    STAssertEqualObjects([controller tableView:controller.tableView titleForHeaderInSection:0], @"3/3/3", @"");
}

@end