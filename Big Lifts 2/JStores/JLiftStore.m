#import "JLiftStore.h"
#import "JLift.h"

@implementation JLiftStore

- (Class)modelClass {
    return JLift.class;
}

- (void)setDefaultsForObject:(id)object {
    JLift *lift = object;
    lift.weight = N(0);
}

@end