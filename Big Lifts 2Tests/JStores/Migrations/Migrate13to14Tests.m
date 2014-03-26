#import "Migrate13to14Tests.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "Migrate13to14.h"

@implementation Migrate13to14Tests

- (void)testRemovesNilWeightAndRepsFromSetLog {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.weight = nil;
    set1.reps = nil;

    [[Migrate13to14 new] removeNilWeightAndRepsFromLog];

    STAssertNotNil(set1.weight, @"");
    STAssertNotNil(set1.reps, @"");
}

@end