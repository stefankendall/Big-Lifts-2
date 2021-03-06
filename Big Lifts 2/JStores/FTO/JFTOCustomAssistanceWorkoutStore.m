#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"
#import "JFTONoneAssistanceCopy.h"
#import "JFTOAssistance.h"
#import "JFTOBoringButBigAssistanceCopy.h"
#import "JFTOTriumvirateAssistanceCopy.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JLift.h"

@implementation JFTOCustomAssistanceWorkoutStore

- (Class)modelClass {
    return JFTOCustomAssistanceWorkout.class;
}

- (void)setDefaultsForObject:(id)object {
    [super setDefaultsForObject:object];
    JFTOCustomAssistanceWorkout *customAssistanceWorkout = object;
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
    NSArray *allLifts = [[JFTOLiftStore instance] findAll];

    NSMutableArray *toRemove = [@[] mutableCopy];
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [self findAll]) {
        if (![allLifts containsObject:customAssistanceWorkout.mainLift]) {
            [toRemove addObject:customAssistanceWorkout];
        }
    }

    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in toRemove) {
        [self remove:customAssistanceWorkout];
    }
}

- (void)addMissingWorkouts {
    for (JFTOLift *lift in [[JFTOLiftStore instance] findAll]) {
        if (![self find:@"mainLift" value:lift]) {
            JFTOCustomAssistanceWorkout *customAssistanceWorkout = [self create];
            customAssistanceWorkout.mainLift = lift;
        }
    }
}

- (void)copyTemplate:(NSString *)variant {
    NSDictionary *copiers = @{
            FTO_ASSISTANCE_NONE : [JFTONoneAssistanceCopy new],
            FTO_ASSISTANCE_BORING_BUT_BIG : [JFTOBoringButBigAssistanceCopy new],
            FTO_ASSISTANCE_TRIUMVIRATE : [JFTOTriumvirateAssistanceCopy new],
    };
    NSObject <AssistanceCopy> *copier = copiers[variant];
    [copier copyTemplate];
}

- (void)removeSetsForMissingAssistanceLifts {
    for (JFTOCustomAssistanceWorkout *customAssistanceWorkout in [self findAll]) {
        NSMutableArray *deadSets = [@[] mutableCopy];
        for (JSet *set in customAssistanceWorkout.workout.sets) {
            if ([set.lift isDead]) {
                [deadSets addObject:set];
            }
        }
        [customAssistanceWorkout.workout removeSets:deadSets];
    }
}

@end