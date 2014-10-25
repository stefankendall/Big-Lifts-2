#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JLiftStore.h"
#import "JLift.h"
#import "JWorkoutStore.h"
#import "JSetStore.h"
#import "JFTOSetStore.h"

@implementation JLiftStore

- (id)init {
    self = [super init];
    if (self) {
        self.isSettingDefaults = NO;
    }
    return self;
}

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

- (void)incrementLifts {
    [[self findAll] each:^(JLift *lift) {
        [lift setWeight:[lift.weight decimalNumberByAdding:lift.increment]];
    }];
}

- (void)removeAtIndex:(int)index1 {
    [super removeAtIndex:index1];
    [self liftsChanged];
}

- (void)remove:(id)object {
    [super remove:object];
    [self liftsChanged];
}

- (void)liftsChanged {
    [[JSetStore instance] adjustToLifts];
    [[JFTOSetStore instance] adjustToLifts];
    [[JWorkoutStore instance] adjustForDeadSetsAndLifts];
}

- (id)create {
    JLift *lift = [super create];
    if (!self.isSettingDefaults) {
        [self liftsChanged];
    }
    return lift;
}

@end