#import "FTOSixWeekPlan.h"
#import "Lift.h"
#import "FTOStandardPlan.h"

@implementation FTOSixWeekPlan
- (NSDictionary *)generate:(Lift *)lift {
    NSMutableDictionary *setsByWeek = [[[FTOStandardPlan new] generate:lift] mutableCopy];
    [setsByWeek removeObjectForKey:@4];

    NSDictionary *secondHalf = [[FTOStandardPlan new] generate:lift];
    for (int i = 4; i <= 7; i++) {
        setsByWeek[[NSNumber numberWithInt:i]] = secondHalf[[NSNumber numberWithInt:(i - 3)]];
    }

    return setsByWeek;
}

- (NSArray *)deloadWeeks {
    return @[@7];
}

- (NSArray *)incrementMaxesWeeks {
    return @[@3, @7];
}

- (NSArray *)weekNames {
    return @[@"5/5/5", @"3/3/3", @"5/3/1", @"5/5/5", @"3/3/3", @"5/3/1", @"Deload"];
}


@end