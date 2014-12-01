#import "JFTOCustomAssistanceLiftStore.h"
#import "JFTOCustomAssistanceLift.h"
#import "JFTOCustomAssistanceWorkoutStore.h"

@implementation JFTOCustomAssistanceLiftStore

- (Class)modelClass {
    return JFTOCustomAssistanceLift.class;
}

- (void)setDefaultsForObject:(id)object {
    [super setDefaultsForObject:object];
    JFTOCustomAssistanceLift *lift = object;

    NSNumber *order = [self max:@"order"];
    lift.order = order ? @([order intValue] + 1) : @0;
    lift.increment = N(0);
}

- (void)liftsChanged {
    [[JFTOCustomAssistanceWorkoutStore instance] removeSetsForMissingAssistanceLifts];
    [super liftsChanged];
}

@end