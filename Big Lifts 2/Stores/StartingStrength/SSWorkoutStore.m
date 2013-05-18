#import "BLStore.h"
#import "SSWorkoutStore.h"
#import "SSWorkout.h"
#import "ContextManager.h"

@implementation SSWorkoutStore

- (NSString *)modelName {
    return @"SSWorkout";
}

- (void)setupDefaults {
    if ([self count] == 0) {
        SSWorkout *liftA = [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[ContextManager context]];
        [liftA setName:@"A"];

        SSWorkout *liftB = [NSEntityDescription insertNewObjectForEntityForName:[self modelName] inManagedObjectContext:[ContextManager context]];
        [liftB setName:@"B"];
    }
}


@end