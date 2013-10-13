#import "FTOCustomCopyTemplateViewControllerTests.h"
#import "FTOCustomCopyTemplateViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "NSDictionary+Enumerable.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "FTOVariant.h"

@implementation FTOCustomCopyTemplateViewControllerTests

- (void)testCopiesTemplatesIntoCustom {
    FTOCustomCopyTemplateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomCopyTemplate"];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[self rowFor:controller.pyramid forController:controller] inSection:0]];
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals(customWorkout.workout.sets.count, 8U, @"");
}

- (void)testFindsVariantForRow {
    FTOCustomCopyTemplateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomCopyTemplate"];
    STAssertEqualObjects([controller variantForRow:0], FTO_VARIANT_STANDARD, @"");
    STAssertEqualObjects([controller variantForRow:[self rowFor:controller.pyramid forController:controller]], FTO_VARIANT_PYRAMID, @"");
}

- (NSInteger)rowFor:(UITableViewCell *)cell forController:(FTOCustomCopyTemplateViewController *)controller {
    return [[controller.rowCellMapping detect:^BOOL(id key, UITableViewCell *cellInMapping) {
        return cell == cellInMapping;
    }] intValue];
}

@end