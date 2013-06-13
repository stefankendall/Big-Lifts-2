#import "PurchaseStoreTests.h"
#import "PurchaseStore.h"
#import "Purchase.h"
#import "BLStoreManager.h"

@implementation PurchaseStoreTests

- (void)setUp {
    [[BLStoreManager instance] resetAllStores];
}

- (void)testFindsPurchasesByName {
    PurchaseStore *store = [PurchaseStore instance];
    Purchase *barPurchase = [store create];
    barPurchase.name = @"barLoading";

    Purchase *p = [store find:@"name" value:@"barLoading"];
    STAssertNotNil(p, @"");
}

@end