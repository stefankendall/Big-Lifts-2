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

- (void)adjustToLifts {
    for (JWorkout *workout in [[JWorkoutStore instance] findAll]) {
        NSMutableArray *deadSets = [@[] mutableCopy];
        for (JSet *set in workout.sets) {
            if ([set.lift isDead]) {
                [deadSets addObject:set];
            }
        }
        [workout removeSets:deadSets];
    }
}

@end