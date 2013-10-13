#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOTriumvirateAssistance.h"
#import "FTOWorkoutStore.h"
#import "FTOLift.h"
#import "FTOTriumvirateStore.h"
#import "FTOTriumvirate.h"
#import "Workout.h"
#import "FTOWorkout.h"
#import "Set.h"

@implementation FTOTriumvirateAssistance

- (void)setup {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *workout) {
        FTOLift *mainLift = (FTOLift *) [workout.workout.sets[0] lift];
        FTOTriumvirate *assistance = [[FTOTriumvirateStore instance] find:@"mainLift" value:mainLift];
        if (assistance) {
            [workout.workout addSets:[assistance.workout.sets array]];
        }
    }];
}

- (void)cycleChange {
}

@end