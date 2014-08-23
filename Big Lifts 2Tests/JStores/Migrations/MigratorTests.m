#import "MigratorTests.h"
#import "Migrator.h"

@implementation MigratorTests

- (void)testGetsSortedMigrationVersions {
    NSDictionary *migrations = @{@1 : @"a", @2 : @"b", @3 : @"c", @4 : @"d", @11 : @"e"};
    NSArray *sorted = [[Migrator new] sortedKeys:migrations];

    for (NSUInteger i = 0; i < [sorted count] - 1; i++) {
        STAssertTrue(sorted[i + 1] > sorted[i], @"");
    }
}

@end