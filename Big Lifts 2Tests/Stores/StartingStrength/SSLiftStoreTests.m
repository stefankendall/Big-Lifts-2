#import <SenTestingKit/SenTestingKit.h>
#import "SSLiftStoreTests.h"
#import "SSLiftStore.h"
#import "SSLift.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSLiftStoreTests

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
    SSLift *lift = [store find:@"name" value:@"Bench"];
    STAssertNotNil(lift, @"");
}

- (void)testLiftsGetIncrements {
    SSLiftStore *store = [SSLiftStore instance];
    SSLift *lift = [store find:@"name" value:@"Bench"];
    STAssertEquals([lift.increment doubleValue], 5.0, @"");
}

- (void) testUnitChangeDropsIncrements {
    SSLiftStore *store = [SSLiftStore instance];
    SSLift *lift = [store find:@"name" value:@"Bench"];
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";
    [[SSLiftStore instance] adjustForKg];
    STAssertEquals([lift.increment doubleValue], 2.0, @"");
}

- (void) testAddMissingLiftsAddsLifts {
    SSLiftStore *store = [SSLiftStore instance];
    [store addMissingLifts:@[@"Back Extension"]];
    STAssertEquals([[SSLiftStore instance] count], 6, @"");
    SSLift *lift = [[SSLiftStore instance] find:@"name" value:@"Back Extension"];
    STAssertNotNil(lift, @"");
    STAssertEqualObjects(lift.order, @6, @"");
}

- (void) testAddMissingLiftsHonorsUnits {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    SSLiftStore *store = [SSLiftStore instance];
    [store remove:[store find:@"name" value:@"Power Clean"]];
    [store addMissingLifts:@[@"Power Clean"]];
    SSLift *lift = [[SSLiftStore instance] find:@"name" value:@"Power Clean"];
    STAssertEqualObjects(lift.increment, [NSDecimalNumber decimalNumberWithString:@"2"],@"");
}

- (void) testRemoveExtraLifts {
    SSLiftStore *store = [SSLiftStore instance];
    [store removeExtraLifts:@[@"Power Clean"]];
    STAssertEquals([store count], 1, @"");
}

@end