#import "JFTOWorkout.h"
#import "JWorkout.h"

@implementation JFTOWorkout

- (NSArray *)cascadeDeleteProperties {
    return @[@"workout"];
}

@end