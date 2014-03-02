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
#import "CustomAssistanceCopyHelper.h"

@implementation JFTOTriumvirateAssistanceCopy

- (void)copyTemplate {
    [self copyLifts];
    [self copyWorkouts];
}

- (void)copyWorkouts {
    [[[JFTOTriumvirateStore instance] findAll] each:^(JFTOTriumvirate *triumvirate) {
        JFTOCustomAssistanceWorkout *customAssistanceWorkout = [[JFTOCustomAssistanceWorkoutStore instance] find:@"mainLift" value:triumvirate.mainLift];
        [CustomAssistanceCopyHelper copy:triumvirate.workout into:customAssistanceWorkout.workout];
    }];
}

- (void)copyLifts {
    [[[JFTOTriumvirateLiftStore instance] findAll] each:^(JFTOTriumvirateLift *triumvirateLift) {
        JFTOCustomAssistanceLift *customLift = [[JFTOCustomAssistanceLiftStore instance] create];
        [[JLiftStore instance] copy:triumvirateLift into:customLift];
    }];
}

@end