#import "Migrate2to3.h"
#import "JWorkout.h"
#import "JWorkoutStore.h"
#import "JFTOCustomWorkout.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOCustomWorkoutStore.h"
#import "JFTOWorkoutStore.h"
#import "JSJWorkoutStore.h"
#import "JSSWorkoutStore.h"
#import "JSSWorkout.h"

@implementation Migrate2to3

- (void)run {
    NSArray *orphanedWorkouts = [self findOrphanedWorkouts];
    for (JWorkout *workout in orphanedWorkouts) {
        [[JWorkoutStore instance] remove:workout];
    }
}

- (NSArray *)findOrphanedWorkouts {
    NSMutableArray *orphans = [@[] mutableCopy];
    for (JWorkout *workout in [[JWorkoutStore instance] findAll]) {
        if ([self workoutIsOrphaned:workout]) {
            [orphans addObject:workout];
        }
    }
    return orphans;
}

- (BOOL)workoutIsOrphaned:(JWorkout *)workout {
    NSArray *storesThatUseWorkouts = @[
            [JFTOCustomWorkoutStore instance],
            [JFTOTriumvirateStore instance],
            [JFTOWorkoutStore instance],
            [JSJWorkoutStore instance]
    ];

    for( BLJStore *store in storesThatUseWorkouts){
        if( [store find:@"workout" value:workout] ){
            return NO;
        }
    }

    for(JSSWorkout *jssWorkout in [[JSSWorkoutStore instance] findAll]){
        if([jssWorkout.workouts containsObject:workout]){
            return NO;
        }
    }

    return YES;
}

@end