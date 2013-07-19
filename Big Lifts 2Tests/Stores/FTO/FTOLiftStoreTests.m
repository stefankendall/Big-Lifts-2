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

- (void) testIncrementLifts {
    FTOLift *squat = [[FTOLiftStore instance] find:@"name" value:@"Squat"];
    NSDecimalNumber *weight = [squat.weight copy];
    [[FTOLiftStore instance] incrementLifts];
    STAssertEqualObjects(squat.weight, [weight decimalNumberByAdding:N(10)], @"");
}

@end