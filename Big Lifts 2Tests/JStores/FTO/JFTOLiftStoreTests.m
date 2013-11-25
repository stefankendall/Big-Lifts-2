#import "JFTOLiftStoreTests.h"
#import "JFTOLift.h"
#import "JFTOLiftStore.h"
#import "JSettings.h"
#import "JSettingsStore.h"

@implementation JFTOLiftStoreTests

- (void)testSetsIncrements {
    JFTOLift *lift = [[JFTOLiftStore instance] first];
    STAssertFalse([lift.increment doubleValue] == 0, @"");
}

- (void)testIncrementsHonorsUnits {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";
    [[JFTOLiftStore instance] adjustForKg];
    JFTOLift *press = [[JFTOLiftStore instance] find:@"name" value:@"Press"];
    STAssertEqualObjects(press.increment, [NSDecimalNumber decimalNumberWithString:@"2"], @"");
}

- (void)testIncrementLifts {
    JFTOLift *squat = [[JFTOLiftStore instance] find:@"name" value:@"Squat"];
    NSDecimalNumber *weight = [squat.weight copy];
    [[JFTOLiftStore instance] incrementLifts];
    STAssertEqualObjects(squat.weight, [weight decimalNumberByAdding:N(10)], @"");
}

@end