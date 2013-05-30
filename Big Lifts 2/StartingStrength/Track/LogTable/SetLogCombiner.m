#import "SetLogCombiner.h"
#import "SetLog.h"
#import "SetLogContainer.h"

@implementation SetLogCombiner

- (NSArray *)combineSetLogs:(NSOrderedSet *)setLogs {
    NSMutableArray *combined = [@[] mutableCopy];

    for (SetLog *setLog in setLogs) {
        SetLogContainer *container = [[SetLogContainer alloc] initWithSetLog:setLog];
        if (![combined containsObject:container]) {
            [combined addObject:container];
            container.count = 1;
        }
        else {
            SetLogContainer *existing = [combined objectAtIndex:[combined indexOfObject:container]];
            existing.count++;
        }
    }

    return combined;
}

@end