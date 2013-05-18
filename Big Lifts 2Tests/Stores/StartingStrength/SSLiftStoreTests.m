#import <SenTestingKit/SenTestingKit.h>
#import "SSLiftStoreTests.h"
#import "SSLiftStore.h"
#import "SSLift.h"

@implementation SSLiftStoreTests

- (void)setUp {
    [super setUp];
    [[SSLiftStore instance] empty];
    [[SSLiftStore instance] setupDefaults];
}

- (void)testSetsUpDefaultLifts {
    STAssertEquals([[SSLiftStore instance] count], 5, @"");
}

- (void)testDefaultLiftsAreOrdered {
    SSLiftStore *store = [SSLiftStore instance];
    NSArray *lifts = [store findAll];
    STAssertTrue([[lifts[0] performSelector:@selector(name)] isEqualToString:@"Bench"], @"");
    STAssertTrue([[lifts[1] performSelector:@selector(name)] isEqualToString:@"Deadlift"], @"");
    STAssertTrue([[lifts[2] performSelector:@selector(name)] isEqualToString:@"Power Clean"], @"");
    STAssertTrue([[lifts[3] performSelector:@selector(name)] isEqualToString:@"Press"], @"");
    STAssertTrue([[lifts[4] performSelector:@selector(name)] isEqualToString:@"Squat"], @"");
}

- (void)testLiftsCanBeFoundByName {
    SSLiftStore *store = [SSLiftStore instance];
    SSLift *lift = [store findBy:[NSPredicate predicateWithFormat:@"name == \"Bench\""]];
    STAssertTrue([lift.name isEqualToString:@"Bench"], @"");
}

@end