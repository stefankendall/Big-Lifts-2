#import "Migrate18to19.h"
#import "JDataHelper.h"
#import "JFTOCustomAssistanceWorkoutStore.h"

@implementation Migrate18to19

- (void)run {
    [self removeInvalidFtoCustomAssistanceWorkouts];
}

- (void)removeInvalidFtoCustomAssistanceWorkouts {
    NSArray *data = [JDataHelper read:[JFTOCustomAssistanceWorkoutStore instance]];
    NSMutableArray *cleanData = [@[] mutableCopy];
    for (NSDictionary *dict in data) {
        if (dict[@"mainLift"] && dict[@"workout"] &&
                ![dict[@"mainLift"] isEqual:[NSNull null]] &&
                ![dict[@"workout"] isEqual:[NSNull null]]) {
            [cleanData addObject:dict];
        }
    }
    [JDataHelper write:[JFTOCustomAssistanceWorkoutStore instance] values:cleanData];
}

@end