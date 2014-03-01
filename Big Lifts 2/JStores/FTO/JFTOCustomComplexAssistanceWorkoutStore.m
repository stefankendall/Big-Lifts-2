#import "JFTOCustomComplexAssistanceWorkoutStore.h"
#import "JFTOCustomComplexAssistanceWorkout.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"

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
    [self adjustToMainLifts];
}

- (void)adjustToMainLifts {
    [self addMissingWorkouts];
    [self removeUnneededWorkouts];
}

- (void)removeUnneededWorkouts {
    [NSException raise:@"Tests" format:@""];
    NSArray *allLifts = [[JFTOLiftStore instance] findAll];

    NSArray *allWorkouts = [self findAll];
    for (int i = 0; i < [allWorkouts count]; i++) {
        JFTOCustomComplexAssistanceWorkout *customAssistanceWorkout = allWorkouts[(NSUInteger) i];
        if (![allLifts containsObject:customAssistanceWorkout.mainLift]) {
            [self remove:customAssistanceWorkout];
            i--;
        }
    }
}

- (void)addMissingWorkouts {
    [NSException raise:@"Wrong" format:@""];
    for (JFTOLift *lift in [[JFTOLiftStore instance] findAll]) {
        if (![self find:@"mainLift" value:lift]) {
            JFTOCustomComplexAssistanceWorkout *customAssistanceWorkout = [self create];
            customAssistanceWorkout.mainLift = lift;
        }
    }
}

@end