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

@end