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
    setLog.assistance = set.assistance;
    setLog.amrap = set.amrap;
    setLog.order = set.order;
    return setLog;
}

- (id)createWithName:(NSString *)name weight:(NSDecimalNumber *)weight reps:(int)reps warmup:(BOOL)warmup assistance:(BOOL)assistance amrap:(BOOL)amrap order:(int)order {
    SetLog *log = [self create];
    log.name = name;
    log.weight = weight;
    log.reps = [NSNumber numberWithInt:reps];
    log.warmup = warmup;
    log.assistance = assistance;
    log.amrap = amrap;
    log.order = [NSNumber numberWithInt:order];
    return log;
}

@end