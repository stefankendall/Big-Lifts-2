#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateAssistance.h"
#import "FTOWorkoutStore.h"
#import "FTOLift.h"
#import "FTOTriumvirateStore.h"
#import "FTOTriumvirate.h"
#import "Workout.h"
#import "FTOWorkout.h"
#import "Set.h"
#import "SetStore.h"

@implementation FTOTriumvirateAssistance

- (void)setup {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *workout) {
        FTOLift *mainLift = (FTOLift *) [workout.workout.orderedSets[0] lift];
        FTOTriumvirate *assistance = [[FTOTriumvirateStore instance] find:@"mainLift" value:mainLift];
        if (assistance) {
            for (Set *set in assistance.workout.orderedSets) {
                [workout.workout addSet:[[SetStore instance] createFromSet:set]];
            }
        }
    }];
}

- (void)cycleChange {
}

@end