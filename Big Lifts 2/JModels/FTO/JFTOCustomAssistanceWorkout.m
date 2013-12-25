#import "JFTOCustomAssistanceWorkout.h"
#import "JWorkout.h"

@implementation JFTOCustomAssistanceWorkout

- (NSArray *)cascadeDeleteProperties {
    return @[@"workout"];
}

@end