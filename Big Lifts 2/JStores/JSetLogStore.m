#import "JSetLogStore.h"
#import "JSetLog.h"
#import "JSet.h"
#import "JLift.h"

@implementation JSetLogStore

- (Class)modelClass {
    return JSetLog.class;
}

- (id)createFromSet:(JSet *)set {
    JSetLog *setLog = [self create];
    setLog.reps = set.reps;
    setLog.weight = [set roundedEffectiveWeight];
    setLog.name = set.lift.name;
    setLog.warmup = set.warmup;
    setLog.assistance = set.assistance;
    setLog.amrap = set.amrap;
    return setLog;
}

- (id)createWithName:(NSString *)name weight:(NSDecimalNumber *)weight reps:(int)reps warmup:(BOOL)warmup assistance:(BOOL)assistance amrap:(BOOL)amrap order:(int)order {
    JSetLog *log = [self create];
    log.name = name;
    log.weight = weight;
    log.reps = [NSNumber numberWithInt:reps];
    log.warmup = warmup;
    log.assistance = assistance;
    log.amrap = amrap;
    return log;
}

@end