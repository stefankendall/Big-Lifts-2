#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOBoringButBigAssistance.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"

@implementation FTOBoringButBigAssistance

- (void)setup {
    [self removeAmrapFromWorkouts];
}

- (void)removeAmrapFromWorkouts {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        [[[ftoWorkout.workout sets] array] each:^(Set *set) {
            set.amrap = NO;
        }];
    }];
}

@end