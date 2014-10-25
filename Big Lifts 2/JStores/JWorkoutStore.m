#import "JWorkoutStore.h"
#import "JWorkout.h"
#import "JSet.h"
#import "JLift.h"

@implementation JWorkoutStore

- (Class)modelClass {
    return JWorkout.class;
}

- (void)setDefaultsForObject:(id)object {
    JWorkout *workout = object;
    workout.sets = [@[] mutableCopy];
}

- (void)adjustForDeadSetsAndLifts {
    for (JWorkout *workout in self.data) {
        NSMutableArray *deadSets = [@[] mutableCopy];
        for (JSet *set in workout.sets) {
            if ([set isDead] || [set.lift isDead]) {
                [deadSets addObject:set];
            }
        }

        [workout removeSets:deadSets];
    }
}

@end