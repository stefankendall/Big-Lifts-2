#import "FTOLiftStoreTests.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation FTOLiftStoreTests

- (void)testSetsIncrements {
    FTOLift *lift = [[FTOLiftStore instance] first];
    STAssertFalse([lift.increment doubleValue] == 0, @"");
}

- (void)testIncrementsHonorsUnits {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";
    [[FTOLiftStore instance] adjustForKg];
    FTOLift *press = [[FTOLiftStore instance] find:@"name" value:@"Press"];
    STAssertEqualObjects(press.increment, [NSDecimalNumber decimalNumberWithString:@"2"], @"");
}

- (void)testIncrementLifts {
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSDecimalNumber *weight = [squat.weight copy];
    [[FTOLiftStore instance] incrementLifts];
    STAssertEqualObjects(squat.weight, [weight decimalNumberByAdding:N(10)], @"");
}

- (void)testRemovesUnusedLiftsWhenDataSyncs {
    FTOLift *badLift1 = [[FTOLiftStore instance] create];
    STAssertTrue([[[FTOLiftStore instance] findAll] containsObject:badLift1], @"");
    [[FTOLiftStore instance] dataWasSynced];
    STAssertFalse([[[FTOLiftStore instance] findAll] containsObject:badLift1], @"");
    STAssertEquals([[FTOLiftStore instance] count], 4, @"");
}

- (void)testDetectsBrokenOrderingNil {
    FTOLift *lift = [[FTOLiftStore instance] findAll][2];
    lift.order = nil;
    STAssertTrue([[FTOLiftStore instance] orderingBroken], @"");
}

- (void)testDetectsBrokenOrderingDuplication {
    FTOLift *lift1 = [[FTOLiftStore instance] findAll][2];
    FTOLift *lift2 = [[FTOLiftStore instance] findAll][3];
    lift1.order = [NSNumber numberWithInt:1];
    lift2.order = [NSNumber numberWithInt:1];
    STAssertTrue([[FTOLiftStore instance] orderingBroken], @"");
}

@end