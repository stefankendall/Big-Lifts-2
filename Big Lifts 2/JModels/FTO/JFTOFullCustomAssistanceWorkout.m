#import "JFTOFullCustomAssistanceWorkout.h"
#import "JWorkout.h"
#import "JFTOLift.h"

@implementation JFTOFullCustomAssistanceWorkout

- (NSArray *)cascadeDeleteProperties {
    return @[@"workout"];
}

@end