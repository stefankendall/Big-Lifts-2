#import "JFTOFullCustomWorkoutStore.h"
#import "JFTOFullCustomWorkout.h"
#import "JWorkoutStore.h"
#import "JWorkout.h"

@implementation JFTOFullCustomWorkoutStore

- (Class)modelClass {
    return JFTOFullCustomWorkout.class;
}

- (void)setDefaultsForObject:(id)object {
    JFTOFullCustomWorkout *customWorkout = object;
    customWorkout.workout = [[JWorkoutStore instance] create];
}

- (void)setupDefaults {
}

- (void)onLoad {
    [self fixNilWorkouts];
}

//delete after a while.
- (void)fixNilWorkouts {
    NSMutableArray *dead = [@[] mutableCopy];
    for (JFTOFullCustomWorkout *fullCustomWorkout in [[JFTOFullCustomWorkoutStore instance] findAll]) {
        if (fullCustomWorkout.workout == nil) {
            fullCustomWorkout.workout = [[JWorkoutStore instance] create];
        }
    }
}

@end