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

- (void)copy:(JLift *)source into:(JLift *)dest {
    dest.name = source.name;
    dest.weight = source.weight;
    dest.increment = source.increment;
    dest.order = source.order;
    dest.usesBar = source.usesBar;
}

@end