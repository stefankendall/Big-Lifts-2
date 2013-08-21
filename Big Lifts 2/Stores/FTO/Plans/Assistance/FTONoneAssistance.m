#import "FTONoneAssistance.h"
#import "FTOWorkoutStore.h"

@implementation FTONoneAssistance

- (void)setup {
    [[FTOWorkoutStore instance] switchTemplate];
}

- (void)cycleChange {
}

@end