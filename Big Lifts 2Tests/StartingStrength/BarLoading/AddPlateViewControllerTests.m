#import "AddPlateViewControllerTests.h"
#import "AddPlateViewController.h"
#import "SenTestCase+ControllerTestAdditions.h"
#import "JPlateStore.h"
#import "JPlate.h"

@implementation AddPlateViewControllerTests

- (void)testTappingAddPlateSavesPlate {
    AddPlateViewController *controller = [self getControllerByStoryboardIdentifier:@"addPlate"];
    [controller.weightTextField setText:@"100"];
    [controller.countTextField setText:@"14"];

    int oldCount = [[JPlateStore instance] count];
    [controller saveTapped:nil];

    STAssertEquals([[JPlateStore instance] count], oldCount + 1, @"");
    JPlate *p = [[JPlateStore instance] atIndex:0];
    STAssertEquals([p.count intValue], 14, @"");
}

- (void)testViewDidAppearResetsForm {
    AddPlateViewController *controller = [self getController];
    [controller viewDidAppear:YES];
    STAssertFalse([controller.saveButton isEnabled], @"");
    STAssertTrue([[controller.weightTextField text] isEqualToString:@""], @"");
    STAssertTrue([[controller.countTextField text] isEqualToString:@""], @"");
}

- (AddPlateViewController *)getController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    AddPlateViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"addPlate"];
    UINavigationController *mainNav = [UINavigationController new];
    [mainNav setViewControllers:@[controller]];

    [controller viewDidLoad];

    return controller;
}

@end