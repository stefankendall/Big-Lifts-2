#import "FTOWorkoutChangeCacheTests.h"
#import "FTOWorkoutChangeCache.h"
#import "JFTOWorkoutStore.h"
#import "FTOWorkoutChange.h"

@implementation FTOWorkoutChangeCacheTests

- (void)setUp{
    [super setUp];
    [[FTOWorkoutChangeCache instance] clear];
}

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
    SetChange *change = [[FTOWorkoutChangeCache instance] changeForWorkout:ftoWorkout set:0];
    STAssertNotNil(change, @"");
}

- (void)testCanClearCache {
    [[FTOWorkoutChangeCache instance] changeForWorkout:[[JFTOWorkoutStore instance] first]];
    [[FTOWorkoutChangeCache instance] clear];
    STAssertEquals((int) [[[FTOWorkoutChangeCache instance] ftoWorkoutChanges] count], 0, @"");
}

- (void)testMarksAndDetectsSetsComplete {
    [[FTOWorkoutChangeCache instance] toggleComplete:NSIP(0, 0)];
    [[FTOWorkoutChangeCache instance] toggleComplete:NSIP(1, 1)];
    STAssertTrue([[FTOWorkoutChangeCache instance] isComplete:NSIP(0, 0)], @"");
    STAssertTrue([[FTOWorkoutChangeCache instance] isComplete:NSIP(1, 1)], @"");
    STAssertFalse([[FTOWorkoutChangeCache instance] isComplete:NSIP(1, 0)], @"");
    STAssertFalse([[FTOWorkoutChangeCache instance] isComplete:NSIP(0, 1)], @"");
}

- (void)testTogglesCompletedSets {
    [[FTOWorkoutChangeCache instance] toggleComplete:NSIP(0, 0)];
    STAssertTrue([[FTOWorkoutChangeCache instance] isComplete:NSIP(0, 0)], @"");
    [[FTOWorkoutChangeCache instance] toggleComplete:NSIP(0, 0)];
    STAssertFalse([[FTOWorkoutChangeCache instance] isComplete:NSIP(0, 0)], @"");
}

@end