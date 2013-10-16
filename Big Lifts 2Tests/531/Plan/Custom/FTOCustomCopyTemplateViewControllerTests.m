#import "FTOCustomCopyTemplateViewControllerTests.h"
#import "FTOCustomCopyTemplateViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "FTOCustomWorkoutStore.h"
#import "FTOCustomWorkout.h"
#import "Workout.h"
#import "FTOVariant.h"
#import "IAPAdapter.h"
#import "Purchaser.h"

@implementation FTOCustomCopyTemplateViewControllerTests

- (void)testCopiesTemplatesIntoCustom {
    FTOCustomCopyTemplateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomCopyTemplate"];
    int pyramidRow = [[controller purchasedOrderedVariants] indexOfObject:FTO_VARIANT_PYRAMID];
    [controller tableView:controller.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:pyramidRow inSection:0]];
    FTOCustomWorkout *customWorkout = [[FTOCustomWorkoutStore instance] findAllWhere:@"week" value:@1][0];
    STAssertEquals(customWorkout.workout.sets.count, 8U, @"");
}

- (void)testDoesNotShowAdvancedWithoutIap {
    FTOCustomCopyTemplateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomCopyTemplate"];
    STAssertFalse([self hasVariant:FTO_VARIANT_ADVANCED withController:controller], @"");
}

- (void)testHasAdvancedWithIap {
    [[IAPAdapter instance] addPurchase:IAP_FTO_ADVANCED];
    FTOCustomCopyTemplateViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoCustomCopyTemplate"];
    STAssertTrue([self hasVariant:FTO_VARIANT_ADVANCED withController:controller], @"");
}

- (BOOL)hasVariant:(NSString *)variant withController:(FTOCustomCopyTemplateViewController *)controller {
    int rows = [controller tableView:controller.tableView numberOfRowsInSection:0];
    BOOL hasAdvanced = NO;
    for (int row = 0; row < rows; row++) {
        UITableViewCell *cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        NSString *cellVariant = controller.textToVariant[([cell.textLabel text])];
        hasAdvanced |= [cellVariant isEqualToString:variant];
    }
    return hasAdvanced;
}

@end