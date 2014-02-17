#import "JFTOTriumvirateAssistance.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JWorkout.h"
#import "JFTOLift.h"
#import "JSetStore.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOTriumvirate.h"
#import "JSet.h"

@implementation JFTOTriumvirateAssistance

- (void)setup {
    for (JFTOWorkout *workout in [[JFTOWorkoutStore instance] findAll]) {
        if ([workout.workout.sets count] == 0) {
            continue;
        }

        JFTOLift *mainLift = [workout.workout.sets[0] lift];
        JFTOTriumvirate *assistance = [[JFTOTriumvirateStore instance] find:@"mainLift" value:mainLift];
        if (assistance) {
            for (JSet *set in assistance.workout.sets) {
                [workout.workout addSet:[[JSetStore instance] createFromSet:set]];
            }
        }
    };
}

- (void)cycleChange {
}

@end