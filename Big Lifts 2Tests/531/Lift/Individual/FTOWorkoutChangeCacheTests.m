#import "FTOWorkoutChangeCacheTests.h"
#import "FTOWorkoutChangeCache.h"
#import "JFTOWorkoutStore.h"
#import "FTOWorkoutChange.h"

@implementation FTOWorkoutChangeCacheTests

- (void)testCreatesNewCacheEntryWhenRequestingCacheItem {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    FTOWorkoutChange *change = [[FTOWorkoutChangeCache instance] changeForWorkout:ftoWorkout];
    STAssertNotNil(change, @"");
    STAssertEquals(change.workout, ftoWorkout, @"");
    STAssertEqualObjects(change.changesBySet, @{}, @"");
    STAssertEquals((int) [[[FTOWorkoutChangeCache instance] ftoWorkoutChanges] count], 1, @"");
}

- (void)testCreatesSetChangeWhenRequested {
    JFTOWorkout *ftoWorkout = [[JFTOWorkoutStore instance] first];
    SetChange *change = [[FTOWorkoutChangeCache instance] changeForWorkout:ftoWorkout set: 0];
    STAssertNotNil(change, @"");
}

- (void)testCanClearCache {
    [[FTOWorkoutChangeCache instance] changeForWorkout:[[JFTOWorkoutStore instance] first]];
    [[FTOWorkoutChangeCache instance] clear];
    STAssertEquals((int) [[[FTOWorkoutChangeCache instance] ftoWorkoutChanges] count], 0, @"");
}

@end