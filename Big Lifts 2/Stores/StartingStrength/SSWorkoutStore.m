#import "BLStore.h"
#import "SSWorkoutStore.h"

@implementation SSWorkoutStore

- (NSString *)modelName {
    return @"SSWorkout";
}

+ (BLStore *)instance {
    static SSWorkoutStore *store = nil;
    if (!store) {
        store = (SSWorkoutStore *) [[super allocWithZone:nil] init];
        [store setupDefaults];
    }
    return store;
}

- (void)setupDefaults {
    if ([self count] == 0) {
        NSLog(@"Create a workout brah");
    }
}


@end