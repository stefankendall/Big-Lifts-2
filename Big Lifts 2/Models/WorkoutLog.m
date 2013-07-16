#import <MRCEnumerable/NSArray+Enumerable.h>
#import "WorkoutLog.h"
#import "SetLog.h"

@implementation WorkoutLog
- (NSArray *)workSets {
    return [[self.sets array] select:^BOOL(SetLog *setLog) {
        return !setLog.warmup;
    }];
}


@end