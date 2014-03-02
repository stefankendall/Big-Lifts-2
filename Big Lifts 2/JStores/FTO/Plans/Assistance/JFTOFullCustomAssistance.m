#import "JFTOFullCustomAssistance.h"
#import "JFTOCustomAssistance.h"
#import "JFTOFullCustomAssistanceWorkout.h"
#import "JFTOFullCustomAssistanceWorkoutStore.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "NSArray+Enumerable.h"
#import "JWorkout.h"
#import "JSet.h"
#import "CustomAssistanceHelper.h"

@implementation JFTOFullCustomAssistance

- (void)setup {
    for (JFTOFullCustomAssistanceWorkout *fullCustomAssistance in [[JFTOFullCustomAssistanceWorkoutStore instance] findAll]) {
        JFTOWorkout *ftoWorkout = [self findFtoWorkoutFor:fullCustomAssistance];
        [CustomAssistanceHelper addAssistanceToWorkout:ftoWorkout withAssistance:fullCustomAssistance.workout];
    }
}

- (JFTOWorkout *)findFtoWorkoutFor:(JFTOFullCustomAssistanceWorkout *)workout {
    return [[[JFTOWorkoutStore instance] findAll] detect:^BOOL(JFTOWorkout *jftoWorkout) {
        JFTOLift *firstLift = [jftoWorkout.workout.sets[0] lift];
        return [workout.week isEqualToNumber:jftoWorkout.week] && workout.mainLift == firstLift;
    }];
}

- (void)cycleChange {
    [[JFTOCustomAssistance new] cycleChange];
}

@end