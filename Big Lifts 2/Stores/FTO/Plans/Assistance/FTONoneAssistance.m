#import "FTONoneAssistance.h"
#import "FTOWorkoutStore.h"

@implementation FTONoneAssistance

- (void)setup {
    [[FTOWorkoutStore instance] switchTemplate];
}

@end