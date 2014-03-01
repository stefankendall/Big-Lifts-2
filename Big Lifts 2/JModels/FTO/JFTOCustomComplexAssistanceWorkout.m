#import "JFTOCustomComplexAssistanceWorkout.h"
#import "JWorkout.h"
#import "JFTOLift.h"

@implementation JFTOCustomComplexAssistanceWorkout

- (NSArray *)cascadeDeleteProperties {
    return @[@"workout"];
}

@end