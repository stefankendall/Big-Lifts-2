#import "SetLogCombiner.h"
#import "SetLog.h"
#import "SetLogContainer.h"

@implementation SetLogCombiner

- (NSArray *)combineSetLogs:(NSOrderedSet *)setLogs {
    NSMutableArray *combined = [@[] mutableCopy];

    for (int i = 0; i < [setLogs count]; i++) {
        SetLog *setLog = setLogs[(NSUInteger) i];
        SetLogContainer *container = [[SetLogContainer alloc] initWithSetLog:setLog];
        if (![combined containsObject:container]) {
            [combined addObject:container];
            container.count = 1;
        }
        else if (i > 0) {
            SetLog *lastSetLog = setLogs[(NSUInteger) (i - 1)];
            SetLogContainer *lastContainer = [[SetLogContainer alloc] initWithSetLog:lastSetLog];
            if ([container isEqual:lastContainer]) {
                SetLogContainer *existing = [combined objectAtIndex:[combined indexOfObject:container]];
                existing.count++;
            }
            else {
                [combined addObject:container];
                container.count = 1;
            }
        }
    }

    return combined;
}

@end