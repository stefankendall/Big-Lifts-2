#import "Workout.h"
#import "FTOTriumvirateStoreTests.h"
#import "BLStore.h"
#import "FTOTriumvirateStore.h"
#import "FTOTriumvirate.h"
#import "FTOLiftStore.h"

@implementation FTOTriumvirateStoreTests

- (void)testCreatesTriumvirateData {
    FTOTriumvirate *benchGroup = [[FTOTriumvirateStore instance] find:@"mainLift" value:
            [[FTOLiftStore instance] find:@"name" value:@"Bench"]];
    STAssertEquals([benchGroup.workout.orderedSets count], 10U, @"");
    STAssertEquals([[FTOTriumvirateStore instance] count], 4, @"");
}

@end