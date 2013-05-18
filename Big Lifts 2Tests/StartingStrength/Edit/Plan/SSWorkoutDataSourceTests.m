#import "SSWorkoutDataSourceTests.h"
#import "SSWorkoutStore.h"
#import "SSWorkoutDataSource.h"

@implementation SSWorkoutDataSourceTests

- (void)setUp {
    [super setUp];
    [[SSWorkoutStore instance] empty];
    [[SSWorkoutStore instance] setupDefaults];
}

- (void)testNumberOfRowsInSection {
    SSWorkoutDataSource *source = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    STAssertEquals(3, [source tableView:nil numberOfRowsInSection:0], @"");
}
@end