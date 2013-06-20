#import "PlateStoreTests.h"
#import "BLStoreManager.h"
#import "PlateStore.h"
#import "Plate.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation PlateStoreTests

- (void)testHasDefaultPlates {
    STAssertEquals([[PlateStore instance] count], 6, @"" );
    Plate *plate = [[PlateStore instance] first];
    STAssertEquals([[plate count] intValue], 6, @"");
}

- (void)testCanFindPlatesSortedByWeight {
    NSArray *allPlates = [[PlateStore instance] findAll];
    for (int i = 0; i < [allPlates count] - 1; i++) {
        Plate *currentPlate = allPlates[i];
        Plate *nextPlate = allPlates[i + 1];

        double weight1 = [currentPlate.weight doubleValue];
        double weight2 = [nextPlate.weight doubleValue];
        STAssertTrue(weight1 > weight2, @"%f came before %f", weight1, weight2);
    }
}

- (void)testAdjustsWhenUnitsChange {
    Settings *settings = [[SettingsStore instance] first];
    settings.units = @"kg";

    [[PlateStore instance] adjustForKg];

    Plate *plate = [[PlateStore instance] first];
    STAssertEquals([plate.weight doubleValue], 20.0, @"");
}

@end