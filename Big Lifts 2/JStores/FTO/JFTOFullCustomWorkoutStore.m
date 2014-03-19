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

@end