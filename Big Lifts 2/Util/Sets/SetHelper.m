#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SetHelper.h"
#import "Set.h"
#import "SetLog.h"
#import "SetLog.h"

@implementation SetHelper
- (Set *)heaviestAmrapSet:(NSArray *)sets {
    __block Set *heaviestAmrap = nil;
    [sets each:^(Set *testSet) {
        if ([testSet amrap]) {
            if (!heaviestAmrap) {
                heaviestAmrap = testSet;
            }
            else if ([testSet.roundedEffectiveWeight
                    compare:heaviestAmrap.roundedEffectiveWeight] == NSOrderedDescending) {
                heaviestAmrap = testSet;
            }
        }
    }];
    return heaviestAmrap;
}

- (SetLog *)heaviestAmrapSetLog:(NSArray *)sets {
    __block SetLog *heaviestAmrap = nil;
    [sets each:^(SetLog *testSet) {
        if ([testSet amrap]) {
            if (!heaviestAmrap) {
                heaviestAmrap = testSet;
            }
            else if ([testSet.weight compare:heaviestAmrap.weight] == NSOrderedDescending) {
                heaviestAmrap = testSet;
            }
        }
    }];
    return heaviestAmrap;
}
@end