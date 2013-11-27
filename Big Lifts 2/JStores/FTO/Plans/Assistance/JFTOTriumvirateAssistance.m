#import <MRCEnumerable/NSArray+Enumerable.h>
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
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *workout) {
        JFTOLift *mainLift = [workout.workout.orderedSets[0] lift];
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