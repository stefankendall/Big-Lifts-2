#import "JWorkoutStore.h"
#import "JWorkout.h"

@implementation JWorkoutStore

- (Class)modelClass {
    return JWorkout.class;
}

- (void)setDefaultsForObject:(id)object {
    JWorkout *workout = object;
    workout.sets = [@[] mutableCopy];
}

@end