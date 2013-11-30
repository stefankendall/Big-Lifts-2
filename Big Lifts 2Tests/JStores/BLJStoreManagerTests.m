#import "BLJStoreManagerTests.h"
#import "JLift.h"
#import "JLiftStore.h"
#import "BLJStoreManager.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"

@implementation BLJStoreManagerTests

- (void)testFindsStoreByClass {
    STAssertEquals([[BLJStoreManager instance] storeForModel:JLift.class], [JLiftStore instance], @"");
    STAssertEquals([[BLJStoreManager instance] storeForModel:JFTOLift.class], [JFTOLiftStore instance], @"");
}

@end