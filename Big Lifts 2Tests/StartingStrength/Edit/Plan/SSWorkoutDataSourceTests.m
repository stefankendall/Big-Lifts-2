#import "SSWorkoutDataSourceTests.h"
#import "SSWorkoutStore.h"
#import "SSWorkoutDataSource.h"
#import "SSLiftStore.h"
#import "SSWorkout.h"
#import "SSLift.h"

@implementation SSWorkoutDataSourceTests

- (void)setUp {
    [super setUp];
    [[SSLiftStore instance] reset];
    [[SSWorkoutStore instance] reset];
}

- (void)testNumberOfRowsInSection {
    SSWorkoutDataSource *source = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    STAssertEquals(3, [source tableView:nil numberOfRowsInSection:0], @"");
}

- (void)testMoveRowAtIndexPathSwapsLiftOrder {
    SSWorkoutDataSource *source = [[SSWorkoutDataSource alloc] initWithName:@"A"];
    [source tableView:nil moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    SSLift *lift1 = [[source getWorkout] lifts][0];
    SSLift *lift2 = [[source getWorkout] lifts][1];

    STAssertTrue([lift1.name isEqualToString:@"Bench"], @"");
    STAssertTrue([lift2.name isEqualToString:@"Squat"], @"");
}
@end