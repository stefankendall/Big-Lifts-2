#import "FTOPlanViewControllerTests.h"
#import "FTOPlanViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"

@implementation FTOPlanViewControllerTests

- (void)testSetsUpTrainingMaxFieldOnLoad {
    FTOPlanViewController *controller = [self getControllerByStoryboardIdentifier:@"ftoPlan"];
    STAssertFalse([[controller.trainingMaxField text] isEqualToString:@""], @"");
}

@end