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

@end