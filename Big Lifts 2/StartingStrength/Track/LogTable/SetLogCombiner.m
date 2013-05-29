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
        }
    }

    return [self unwrapContainer:combined];
}

- (NSArray *)unwrapContainer:(NSMutableArray *)setLogContainerArray {
    NSMutableArray *setLogs = [@[] mutableCopy];
    for (SetLogContainer *container in setLogContainerArray) {
        [setLogs addObject:container.setLog];
    }
    return setLogs;
}

@end