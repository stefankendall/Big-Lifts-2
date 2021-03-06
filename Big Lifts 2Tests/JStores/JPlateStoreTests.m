#import "JPlateStoreTests.h"
#import "JPlateStore.h"
#import "JPlate.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JPlateStoreTests

- (void)testHasDefaultPlates {
    STAssertEquals([[JPlateStore instance] count], 6, @"" );
    JPlate *plate = [[JPlateStore instance] first];
    STAssertEquals([[plate count] intValue], 6, @"");
}

- (void)testCanFindPlatesSortedByWeight {
    NSArray *allPlates = [[JPlateStore instance] findAll];
    STAssertTrue([allPlates count] > 0, @"");
    for (int i = 0; i < [allPlates count] - 1; i++) {
        JPlate *currentPlate = allPlates[(NSUInteger) i];
        JPlate *nextPlate = allPlates[(NSUInteger) (i + 1)];

        double weight1 = [currentPlate.weight doubleValue];
        double weight2 = [nextPlate.weight doubleValue];
        STAssertTrue(weight1 > weight2, @"%f came before %f", weight1, weight2);
    }
}

- (void)testAdjustsWhenUnitsChange {
    JSettings *settings = [[JSettingsStore instance] first];
    settings.units = @"kg";
    [[JPlateStore instance] adjustForKg];
    JPlate *plate = [[JPlateStore instance] first];
    STAssertEqualObjects(plate.weight, N(20), @"");
}

@end