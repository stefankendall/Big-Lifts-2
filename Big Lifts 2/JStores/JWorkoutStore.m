#import "JWorkoutStore.h"
#import "JWorkout.h"

@implementation JWorkoutStore

- (Class)modelClass {
    return JWorkout.class;
}

@end