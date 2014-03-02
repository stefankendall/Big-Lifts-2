#import "CustomAssistanceCopyHelper.h"
#import "JLiftStore.h"
#import "JFTOCustomAssistanceLiftStore.h"
#import "JWorkout.h"
#import "JFTOCustomAssistanceLift.h"
#import "JSetStore.h"
#import "JWorkout.h"
#import "JSet.h"

@implementation CustomAssistanceCopyHelper

+ (void)copy:(JWorkout *)source into:(JWorkout *)dest {
    for (JSet *set in [source sets]) {
        JSet *customSet = [[JSetStore instance] createFromSet:set];
        customSet.lift = [[JFTOCustomAssistanceLiftStore instance] find:@"name" value:customSet.lift.name];
        [dest addSet:customSet];
    }
}

@end