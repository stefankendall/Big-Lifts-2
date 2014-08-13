#import "JFTOTriumvirateStoreTests.h"
#import "JFTOLiftStore.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOTriumvirate.h"
#import "JWorkout.h"

@implementation JFTOTriumvirateStoreTests

- (void)testRemovesTriumvirateWhenLiftsAreAdjusted {
    [[JFTOLiftStore instance] removeAtIndex:0];
    STAssertEquals([[JFTOTriumvirateStore instance] count], 3, @"");
}

- (void)testAddsTriumvirateWhenLiftsAreAdded {
    [[JFTOLiftStore instance] create];
    STAssertEquals([[JFTOTriumvirateStore instance] count], 5, @"");
}

- (void)testRemovingALiftDoesntWipeTriumvirate {
    [[JFTOLiftStore instance] removeAtIndex:0];
    JFTOTriumvirate *triumvirate = [[JFTOTriumvirateStore instance] first];
    STAssertFalse([triumvirate.workout.sets count] == 0, @"");
}

@end