#import "JLiftStore.h"
#import "JLift.h"
#import "Lift.h"

@implementation JLiftStore

- (Class)modelClass {
    return JLift.class;
}

- (void)setDefaultsForObject:(id)object {
    Lift *lift = object;
    lift.weight = N(0);
}

@end