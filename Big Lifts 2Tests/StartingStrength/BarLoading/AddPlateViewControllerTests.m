#import "AddPlateViewControllerTests.h"
#import "AddPlateViewController.h"
#import "BLStore.h"
#import "PlateStore.h"
#import "BLStoreManager.h"
#import "Plate.h"

@implementation AddPlateViewControllerTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
}

- (void)testTappingAddPlateSavesPlate {
    AddPlateViewController *controller = [AddPlateViewController new];
    [controller.weightTextField setText:@"100"];
    [controller.countTextField setText:@"4"];

    int oldCount = [[PlateStore instance] count];
    [controller saveTapped:nil];

    STAssertEquals([[PlateStore instance] count], oldCount + 1, @"");
    Plate *p = [[PlateStore instance] findBy:[NSPredicate predicateWithFormat:@"weight == %f", [NSNumber numberWithDouble:100.0]]];
    STAssertNotNil(p, @"");
}

- (void)testViewDidAppearResetsForm {
    AddPlateViewController *controller = [self getController];
    [controller viewDidAppear:YES];
    STAssertFalse([controller.saveButton isEnabled], @"");
    STAssertTrue([[controller.weightTextField text] isEqualToString:@""], @"");
    STAssertTrue([[controller.countTextField text] isEqualToString:@""], @"");
}

- (void)testValidatesWeight {
    AddPlateViewController *controller = [self getController];
    EZFormTextField *weightFormField = [controller.form formFieldForKey:@"weight"];
    [weightFormField setFieldValue:@""];
    STAssertFalse([weightFormField isValid], @"");

    [weightFormField setFieldValue:@"6"];
    STAssertTrue([weightFormField isValid], @"");
}

- (void)testValidatesCount {
    AddPlateViewController *controller = [self getController];
    EZFormTextField *countFormField = [controller.form formFieldForKey:@"count"];
    [countFormField setFieldValue:@""];
    STAssertFalse([countFormField isValid], @"");

    [countFormField setFieldValue:@"6"];
    STAssertTrue([countFormField isValid], @"");
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