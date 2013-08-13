#import "FTOTriumvirateStore.h"
#import "FTOTriumvirate.h"
#import "FTOLiftStore.h"
#import "WorkoutStore.h"
#import "Workout.h"
#import "FTOTriumvirateLift.h"
#import "FTOTriumvirateLiftStore.h"
#import "Set.h"
#import "SetStore.h"

@implementation FTOTriumvirateStore

- (void)setupDefaults {
    FTOTriumvirate *benchLifts = [[FTOTriumvirateStore instance] create];
    benchLifts.mainLift = [[FTOLiftStore instance] find:@"name" value:@"Bench"];
    benchLifts.workout = [[WorkoutStore instance] create];
    [benchLifts.workout.sets addObjectsFromArray: [self benchLifts]];
}

- (NSArray *)benchLifts {
    FTOTriumvirateLift *dumbbellBench = [[FTOTriumvirateLiftStore instance] create];
    dumbbellBench.name = @"Dumbbell Bench";
    NSMutableArray *benchSets = [@[] mutableCopy];
    for( int set = 0; set < 5; set++ ){
        Set *benchSet = [[SetStore instance] create];
        benchSet.lift = dumbbellBench;
        benchSet.reps = @15;
        [benchSets addObject:benchSet];
    }
    return benchSets;
}

@end