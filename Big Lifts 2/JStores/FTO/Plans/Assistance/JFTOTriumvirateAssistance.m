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
#import "JFTOTriumvirateAssistance.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JWorkout.h"
#import "JFTOLift.h"
#import "JSetStore.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOTriumvirate.h"

@implementation JFTOTriumvirateAssistance

- (void)setup {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *workout) {
        JFTOLift *mainLift = (JFTOLift *) [workout.workout.orderedSets[0] lift];
        JFTOTriumvirate *assistance = [[JFTOTriumvirateStore instance] find:@"mainLift" value:mainLift];
        if (assistance) {
            for (JSet *set in assistance.workout.orderedSets) {
                [workout.workout addSet:[[JSetStore instance] createFromSet:set]];
            }
        }
    }];
}

- (void)cycleChange {
}

@end