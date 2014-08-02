#import "JFTOFullCustomWorkout.h"
#import "JFTOFullCustomWorkoutStore.h"
#import "JWorkoutStore.h"

@implementation JFTOFullCustomWorkout

- (NSArray *)cascadeDeleteProperties {
    return @[@"workout"];
}

@end