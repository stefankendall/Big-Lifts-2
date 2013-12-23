#import "JFTOCustomAssistanceWorkout.h"
#import "JWorkout.h"

@implementation JFTOCustomAssistanceWorkout

- (NSArray *)cascadeDeleteClasses {
    return @[JWorkout.class];
}

@end