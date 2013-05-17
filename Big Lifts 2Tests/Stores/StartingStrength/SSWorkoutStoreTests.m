#import <SenTestingKit/SenTestingKit.h>
#import "SSWorkoutStore.h"
#import "SSWorkoutStoreTests.h"

@implementation SSWorkoutStoreTests

- (void)setUp {
    [super setUp];
    [[SSWorkoutStore instance] empty];
    [[SSWorkoutStore instance] setupDefaults];
}

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[SSWorkoutStore instance] count], 2, @"");
}

@end