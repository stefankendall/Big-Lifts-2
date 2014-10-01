#import "CustomAssistanceHelper.h"
#import "JWorkout.h"
#import "JSet.h"
#import "BLJStoreManager.h"
#import "JFTOWorkout.h"
#import "JSetStore.h"

@implementation CustomAssistanceHelper

+ (void)addAssistanceToWorkout:(JFTOWorkout *)ftoWorkout withAssistance:(JWorkout *)assistanceWorkout {
    for (JSet *set in assistanceWorkout.sets) {
        JSetStore *store = [[BLJStoreManager instance] storeForModel:set.class withUuid:set.uuid];
        JSet *assistanceSet = [store createFromSet:set];
        assistanceSet.assistance = YES;
        [ftoWorkout.workout addSet:assistanceSet];
    }
}

@end