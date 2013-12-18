#import "Migrate2to3.h"
#import "JWorkout.h"
#import "JWorkoutStore.h"

@implementation Migrate2to3

- (void)run {
    NSArray *orphanedWorkouts = [self findOrphanedWorkouts];
    for (JWorkout *workout in orphanedWorkouts) {
        [[JWorkoutStore instance] remove:workout];
    }
}

- (NSArray *)findOrphanedWorkouts {
    return @[];
}

@end