#import "BLStore.h"
#import "SSWorkoutStore.h"

@implementation SSWorkoutStore

- (NSString *)modelName {
    return @"SSWorkout";
}

- (void)setupDefaults {
    if ([self count] == 0) {
        NSLog(@"Create a workout brah");
    }
}


@end