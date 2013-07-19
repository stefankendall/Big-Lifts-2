#import "FTOLiftViewControllerTests.h"
#import "FTOLiftViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOVariantStore.h"
#import "FTOWorkoutStore.h"
#import "FTOVariant.h"

@implementation FTOLiftViewControllerTests

- (void)testHasRowsForEachWeek {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    STAssertEquals([controller tableView:nil numberOfRowsInSection:0], 4, @"");
    STAssertEquals([controller numberOfSectionsInTableView:nil], 4, @"");
}

- (void) testHasLiftNamesInCells {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    STAssertEqualObjects([[cell textLabel] text], @"Bench", @"");
}

- (void) testHasSectionsForSixWeek {
    FTOLiftViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoLift"];
    [[[FTOVariantStore instance] first] setName: FTO_VARIANT_SIX_WEEK];
    [[FTOWorkoutStore instance] switchTemplate];

    STAssertEquals([controller numberOfSectionsInTableView:nil], 7, @"");
    STAssertEqualObjects([controller tableView:nil titleForHeaderInSection:3], @"5/5/5", @"");
    STAssertEqualObjects([controller tableView:nil titleForHeaderInSection:6], @"Deload", @"");
}

@end