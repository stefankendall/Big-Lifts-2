#import "SSPlanWorkoutsViewControllerTests.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "SSPlanWorkoutsViewController.h"
#import "SSVariantStore.h"
#import "SSVariant.h"

@implementation SSPlanWorkoutsViewControllerTests

- (void)testSetsVariantNameInButtonOnAppear {
    SSVariant *variant = [[SSVariantStore instance] first];
    variant.name = @"Novice";
    SSPlanWorkoutsViewController *controller = [self getControllerByStoryboardIdentifier:@"ssPlanWorkouts"];
    STAssertEqualObjects([controller.variantButton title], @"Novice", @"");
}

@end