#import "BLStoreManagerTests.h"
#import "BLStoreManager.h"
#import "Set.h"
#import "SetStore.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation BLStoreManagerTests

- (void)testGetsModelNamesFromChangedObjects {
    Set *set = [[SetStore instance] create];
    SSLift *lift = [[SSLiftStore instance] create];
    NSSet *modelNames = [[BLStoreManager instance] getChangedModelNames:[[NSSet alloc] initWithArray:@[set, lift]]];
    STAssertEquals([modelNames count], (NSUInteger) 2, @"");
    STAssertTrue([modelNames containsObject:@"Set"], @"");
    STAssertTrue([modelNames containsObject:@"SSLift"], @"");
}

- (void)testGetChangedStoresFromObjects {
    Set *set = [[SetStore instance] create];
    SSLift *lift = [[SSLiftStore instance] create];
    NSSet *stores = [[BLStoreManager instance] getChangedStoresFromObjects:[[NSSet alloc] initWithArray:@[set, lift]]];
    STAssertEquals([stores count], (NSUInteger) 2, @"");
    STAssertTrue([stores containsObject:[SSLiftStore instance]], @"");
    STAssertTrue([stores containsObject:[SetStore instance]], @"");
}


@end