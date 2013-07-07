#import "SetLogStore.h"
#import "Set.h"
#import "SetLog.h"
#import "Lift.h"

@implementation SetLogStore

- (id)createFromSet:(Set *)set {
    SetLog *setLog = [[SetLogStore instance] create];
    setLog.reps = set.reps;
    setLog.weight = [set roundedEffectiveWeight];
    setLog.name = set.lift.name;
    setLog.warmup = set.warmup;
    return setLog;
}

@end