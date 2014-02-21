#import "Migrate9to10Tests.h"
#import "JDataHelper.h"
#import "JSSLiftStore.h"
#import "Migrate9to10.h"

@implementation Migrate9to10Tests

- (void)testAddsCustomNameToStartingStrength {
    [JDataHelper write:[JSSLiftStore instance] values:@[@{
            @"name" : @"Power Clean",
            @"weight" : N(200),
            @"order" : @0,
            @"increment" : N(5),
            @"usesBar" : @1
    }]];

    [[Migrate9to10 new] run];

    NSArray *values = [JDataHelper read:[JSSLiftStore instance]];
    NSDictionary *value = values[0];
    STAssertTrue([[value allKeys] containsObject:@"customName"], @"");
}

@end