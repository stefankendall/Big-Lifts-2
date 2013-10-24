#import "FTOTriumvirateTests.h"
#import "Set.h"
#import "FTOTriumvirateStore.h"
#import "FTOTriumvirate.h"
#import "Workout.h"

@implementation FTOTriumvirateTests

- (void)testCountsSetsInWorkout {
    FTOTriumvirate *triumvirate = [[FTOTriumvirateStore instance] first];
    Set *set = triumvirate.workout.orderedSets[0];
    int count = [triumvirate countMatchingSets:set];
    STAssertEquals(count, 5, @"");
}

@end