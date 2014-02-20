#import "JFTOTriumvirateAssistanceCopy.h"
#import "JFTOTriumvirateLiftStore.h"
#import "NSArray+Enumerable.h"
#import "JFTOTriumvirateLift.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JLiftStore.h"
#import "JFTOTriumvirate.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JWorkout.h"
#import "JSetStore.h"
#import "JSet.h"

@implementation JFTOTriumvirateAssistanceCopy

- (void)copyTemplate {
    [self copyLifts];
    [self copyWorkouts];
}

- (void)copyWorkouts {
    [[[JFTOTriumvirateStore instance] findAll] each:^(JFTOTriumvirate *triumvirate) {
        JFTOCustomAssistanceWorkout *customAssistanceWorkout = [[JFTOCustomAssistanceWorkoutStore instance] find:@"mainLift" value:triumvirate.mainLift];
        [self copy:triumvirate.workout into:customAssistanceWorkout.workout];
    }];
}

- (void)copy:(JWorkout *)source into:(JWorkout *)dest {
    for (JSet *triumvirateSet in [source sets]) {
        JSet *customSet = [[JSetStore instance] createFromSet:triumvirateSet];
        customSet.lift = [[JFTOCustomAssistanceLiftStore instance] find:@"name" value:customSet.lift.name];
        [dest addSet:customSet];
    }
}

- (void)copyLifts {
    [[[JFTOTriumvirateLiftStore instance] findAll] each:^(JFTOTriumvirateLift *triumvirateLift) {
        JFTOCustomAssistanceLift *customLift = [[JFTOCustomAssistanceLiftStore instance] create];
        [[JLiftStore instance] copy:triumvirateLift into:customLift];
    }];
}

@end