#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOLiftStore.h"
#import "JWorkoutStore.h"
#import "JFTONoneAssistanceCopy.h"
#import "JFTOAssistance.h"
#import "JFTOBoringButBigAssistanceCopy.h"

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

    NSArray *allWorkouts = [self findAll];
    for (int i = 0; i < [allWorkouts count]; i++) {
        JFTOCustomAssistanceWorkout *customAssistanceWorkout = allWorkouts[(NSUInteger) i];
        if (![allLifts containsObject:customAssistanceWorkout.mainLift]) {
            [self remove:customAssistanceWorkout];
            i--;
        }
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
    };
    NSObject <AssistanceCopy> *copier = copiers[variant];
    [copier copyTemplate];
}

@end