#import "JFTOFullCustomWorkoutStore.h"
#import "JFTOFullCustomWorkout.h"
#import "JWorkoutStore.h"
#import "JFTOVariant.h"
#import "JFTOWorkoutSetsGenerator.h"
#import "JFTOLiftStore.h"
#import "JFTOPlan.h"
#import "JSetData.h"
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
    [self createWorkoutsForVariant:FTO_VARIANT_STANDARD];
}

- (void)createWorkoutsForVariant:(NSString *)variant {
    for (JFTOLift *ftoLift in [[JFTOLiftStore instance] findAll]) {
        NSObject <JFTOPlan> *plan = [[JFTOWorkoutSetsGenerator new] planForVariant:variant];
        NSDictionary *setsByWeek = [plan generate:ftoLift];
        NSArray *deloadWeeks = [plan deloadWeeks];
        for (int week = 1; week <= [[setsByWeek allKeys] count]; week++) {
            NSArray *sets = setsByWeek[[NSNumber numberWithInt:week]];
            JFTOFullCustomWorkout *customWorkout = [[JFTOFullCustomWorkoutStore instance] create];
            customWorkout.lift = ftoLift;
            customWorkout.order = ftoLift.order;
            customWorkout.week = [NSNumber numberWithInt:week];
            customWorkout.deload = [deloadWeeks containsObject:[NSNumber numberWithInt:week]];
            customWorkout.incrementAfterWeek = customWorkout.deload;
            for (JSetData *setData in sets) {
                [customWorkout.workout addSet:[setData createSet]];
            }
        }
    }
}

- (void)adjustToMainLifts {

}

@end