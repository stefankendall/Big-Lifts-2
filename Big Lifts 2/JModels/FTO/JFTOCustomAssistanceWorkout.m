#import "JFTOCustomAssistanceWorkout.h"
#import "JLift.h"
#import "JWorkout.h"

@implementation JFTOCustomAssistanceWorkout

- (NSArray *)cascadeDeleteClasses {
    return @[JWorkout.class];
}

@end