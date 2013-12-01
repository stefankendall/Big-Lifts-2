#import <MRCEnumerable/NSArray+Enumerable.h>
#import "SetHelper.h"
#import "JSet.h"
#import "JSetLog.h"

@implementation SetHelper
- (JSet *)heaviestAmrapSet:(NSArray *)sets {
    __block JSet *heaviestAmrap = nil;
    [sets each:^(JSet *testSet) {
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

- (JSetLog *)heaviestAmrapSetLog:(NSArray *)sets {
    __block JSetLog *heaviestAmrap = nil;
    [sets each:^(JSetLog *testSet) {
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