#import "WorkoutStore.h"
#import "Workout.h"
#import "Lift.h"
#import "Set.h"

@implementation WorkoutStore

- (void)onLoad {
    [self correctEmptyOrderOnSets];
}

- (void)correctEmptyOrderOnSets {
    NSArray *allWorkouts = [self findAll];
    for (Workout *workout in allWorkouts) {
        if ([[workout.orderedSets firstObject] order] == nil ) {
            int count = 0;
            for (Set *set in workout.sets) {
                set.order = [NSNumber numberWithInt:count++];
            }
        }
    }
}

@end