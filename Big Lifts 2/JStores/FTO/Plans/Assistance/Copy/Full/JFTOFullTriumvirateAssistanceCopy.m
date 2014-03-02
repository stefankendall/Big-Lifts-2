#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOFullTriumvirateAssistanceCopy.h"
#import "JFTOTriumvirateAssistanceCopy.h"
#import "CustomAssistanceCopyHelper.h"
#import "JFTOCustomAssistanceWorkoutStore.h"
#import "JFTOCustomAssistanceWorkout.h"
#import "JFTOTriumvirate.h"
#import "JFTOTriumvirateStore.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"

@implementation JFTOFullTriumvirateAssistanceCopy

- (void)copyTemplate {
    [[JFTOTriumvirateAssistanceCopy new] copyLifts];
    [self copyWorkouts];
}

- (void)copyWorkouts {
    [[[JFTOTriumvirateStore instance] findAll] each:^(JFTOTriumvirate *triumvirate) {
        NSArray *customAssistanceWorkouts = [[JFTOFullCustomAssistanceWorkoutStore instance] findAllWhere:@"mainLift" value:triumvirate.mainLift];
        for (JFTOFullCustomAssistanceWorkout *customAssistanceWorkout in customAssistanceWorkouts) {
            [CustomAssistanceCopyHelper copy:triumvirate.workout into:customAssistanceWorkout.workout];
        }
    }];
}

@end