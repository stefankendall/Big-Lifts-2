#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOCustomWorkoutStore.h"
#import "JFTOCustomWorkout.h"
#import "JWorkout.h"
#import "JWorkoutStore.h"
#import "JSetData.h"
#import "JFTOWorkoutSetsGenerator.h"
#import "JFTOPlan.h"
#import "JFTOVariant.h"

@implementation JFTOCustomWorkoutStore

- (Class)modelClass {
    return JFTOCustomWorkout.class;
}

- (void)setupDefaults {
    [self createWorkoutsForVariant:FTO_VARIANT_STANDARD];
}

- (void)createWorkoutsForVariant:(NSString *)variant {
    NSDictionary *sets = [[JFTOWorkoutSetsGenerator new] setsFor:nil withTemplate:variant];
    for (int week = 1; week <= [[sets allKeys] count]; week++) {
        [self createWithWorkout:[self createWorkoutForWeek:week variant:variant] week:week order:week variant:variant];
    }
}

- (JWorkout *)createWorkoutForWeek:(int)week variant:(NSString *)variant {
    JWorkout *workout = [[JWorkoutStore instance] create];
    NSDictionary *workoutPlan = [[JFTOWorkoutSetsGenerator new] setsFor:nil withTemplate:variant];
    NSArray *setData = workoutPlan[[NSNumber numberWithInt:week]];
    NSArray *sets = [setData collect:^id(JSetData *data) {
        return [data createSet];
    }];

    [workout addSets:sets];
    return workout;
}

- (void)createWithWorkout:(id)workout week:(int)week order:(int)order variant:(NSString *)variant {
    NSObject <JFTOPlan> *ftoPlan = [[JFTOWorkoutSetsGenerator new] planForVariant:variant];
    JFTOCustomWorkout *customWorkout = [self create];
    customWorkout.workout = workout;
    customWorkout.week = [NSNumber numberWithInt:week];
    customWorkout.order = [NSNumber numberWithInt:order];
    customWorkout.name = [ftoPlan weekNames][(NSUInteger) week - 1];

    customWorkout.deload = [[ftoPlan deloadWeeks] containsObject:[NSNumber numberWithInt:week]];
    customWorkout.incrementAfterWeek = [[ftoPlan incrementMaxesWeeks] containsObject:[NSNumber numberWithInt:week]];
}

- (void)reorderWeeks {
    for (int week = 1; week < [[JFTOCustomWorkoutStore instance] count]; week++) {
        JFTOCustomWorkout *customWorkout = [[JFTOCustomWorkoutStore instance] atIndex:week];
        customWorkout.week = [NSNumber numberWithInt:week];
        customWorkout.order = [NSNumber numberWithInt:week];
    }
}

- (void)setupVariant:(NSString *)variant {
    [self removeAll];
    [self createWorkoutsForVariant:variant];
}

@end