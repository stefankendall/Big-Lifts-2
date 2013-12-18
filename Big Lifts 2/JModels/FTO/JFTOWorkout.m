#import "JFTOWorkout.h"
#import "JWorkout.h"

@implementation JFTOWorkout

- (NSArray *)cascadeDeleteClasses {
    return @[JWorkout.class];
}

@end