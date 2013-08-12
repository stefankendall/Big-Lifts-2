#import "FTOBoringButBigAssistanceTests.h"
#import "FTOBoringButBigAssistance.h"
#import "FTOWorkoutStore.h"
#import "NSArray+Enumerable.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"

@implementation FTOBoringButBigAssistanceTests

- (void) testAddingBoringButBigRemovesAmrap {
    [[FTOBoringButBigAssistance new] setup];

    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *workout) {
        STAssertFalse([[[workout.workout sets] lastObject] amrap], @"");
    }];
}

@end