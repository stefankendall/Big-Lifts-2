#import "JFTOCustomComplexAssistanceWorkoutStore.h"
#import "JFTOCustomComplexAssistanceWorkout.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOLift.h"

@implementation JFTOCustomComplexAssistanceWorkoutStore

- (Class)modelClass {
    return JFTOCustomComplexAssistanceWorkout.class;
}

- (void)setDefaultsForObject:(id)object {
    [super setDefaultsForObject:object];
    JFTOCustomComplexAssistanceWorkout *customAssistanceWorkout = object;
    customAssistanceWorkout.workout = [[JWorkoutStore instance] create];
}

- (void)setupDefaults {
    [self adjustToFtoWorkouts];
}

- (void)adjustToFtoWorkouts {
    [self addMissingWorkouts];
    [self removeUnneededWorkouts];
}

- (void)removeUnneededWorkouts {
    NSArray *lifts = [[JFTOLiftStore instance] findAll];
    NSArray *weeks = [[[JFTOWorkoutStore instance] unique:@"week"] array];

    NSArray *allWorkouts = [self findAll];
    for (int i = 0; i < [allWorkouts count]; i++) {
        JFTOCustomComplexAssistanceWorkout *customAssistanceWorkout = allWorkouts[(NSUInteger) i];
        if (![lifts containsObject:customAssistanceWorkout.mainLift] || ![weeks containsObject:customAssistanceWorkout.week]) {
            [self remove:customAssistanceWorkout];
            i--;
        }
    }
}

- (void)addMissingWorkouts {
    [self addForLifts];
    [self addForWeeks];
}

- (void)addForWeeks {
    NSArray *allWeeks = [[[JFTOWorkoutStore instance] unique:@"week"] array];
    NSArray *existingWeeks = [[[JFTOCustomComplexAssistanceWorkoutStore instance] unique:@"week"] array];
    for (NSNumber *week in allWeeks) {
        if (![existingWeeks containsObject:week]) {
            for (JFTOLift *lift in [[JFTOLiftStore instance] findAll]) {
                JFTOCustomComplexAssistanceWorkout *customAssistanceWorkout = [self create];
                customAssistanceWorkout.mainLift = lift;
                customAssistanceWorkout.week = week;
            }
        }
    }
}

- (void)addForLifts {
    NSArray *weeks = [[[JFTOWorkoutStore instance] unique:@"week"] array];
    for (JFTOLift *lift in [[JFTOLiftStore instance] findAll]) {
        if (![self find:@"mainLift" value:lift]) {
            for (NSNumber *week in weeks) {
                JFTOCustomComplexAssistanceWorkout *customAssistanceWorkout = [self create];
                customAssistanceWorkout.mainLift = lift;
                customAssistanceWorkout.week = week;
            }
        }
    }
}

@end