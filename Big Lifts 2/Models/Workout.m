#import <MRCEnumerable/NSArray+Enumerable.h>
#import "Workout.h"
#import "Set.h"

@implementation Workout

-(NSArray *) workSets {
    return [[self.sets array] select:^BOOL(Set *set) {
        return !set.warmup;
    }];
}

@end