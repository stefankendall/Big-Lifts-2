#import "Migrate13to14.h"
#import "JSetLogStore.h"
#import "JSetLog.h"
#import "DecimalNumberHelper.h"

@implementation Migrate13to14

- (void)run {
    [[JSetLogStore instance] load];
    [self removeNilWeightAndRepsFromLog];
}

- (void)removeNilWeightAndRepsFromLog {
    for(JSetLog *setLog in [[JSetLogStore instance] findAll]){
        setLog.reps = setLog.reps == nil ? @0 : setLog.reps;
        setLog.weight = setLog.weight == nil ? N(0) : setLog.weight;
    }
}

@end