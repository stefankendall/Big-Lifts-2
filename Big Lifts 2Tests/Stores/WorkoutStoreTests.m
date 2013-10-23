#import "Set.h"
#import "WorkoutStoreTests.h"
#import "SetStore.h"
#import "WorkoutStore.h"
#import "Workout.h"

@implementation WorkoutStoreTests

- (void)testSetsOrderOnSetsWhenAdding {
    Workout *workout = [[WorkoutStore instance] create];
    Set *set1 = [[SetStore instance] create];
    Set *set2 = [[SetStore instance] create];
    Set *set3 = [[SetStore instance] create];

    [workout addSets:@[set1, set2, set3]];
    STAssertEquals([set1.order intValue], 0, @"" );
    STAssertEquals([set2.order intValue], 1, @"" );
    STAssertEquals([set3.order intValue], 2, @"" );
}

- (void)testFixesSetsWithBrokenOrderingOnLoad {
    Workout *workout = [[WorkoutStore instance] create];
    Set *set1 = [[SetStore instance] create];
    Set *set2 = [[SetStore instance] create];
    Set *set3 = [[SetStore instance] create];
    [workout addSets:@[set1, set2, set3]];
    set1.order = nil;
    set2.order = nil;
    set3.order = nil;

    [[WorkoutStore instance] onLoad];
    STAssertEquals([set1.order intValue], 0, @"" );
    STAssertEquals([set2.order intValue], 1, @"" );
    STAssertEquals([set3.order intValue], 2, @"" );
}

@end