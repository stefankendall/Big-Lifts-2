#import "JFTOJokerPlan.h"
#import "JSetData.h"
#import "JFTOStandardPlan.h"

@implementation JFTOJokerPlan
- (NSDictionary *)generate:(JLift *)lift {
    NSDictionary *jokerSets = @{
            @1 : @[
                    [JSetData dataWithReps:5 percentage:N(95) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(105) lift:lift],
                    [JSetData dataWithReps:2 percentage:N(110) lift:lift]
            ],
            @2 : @[
                    [JSetData dataWithReps:3 percentage:N(100) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(105) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(115) lift:lift]
            ],
            @3 : @[
                    [JSetData dataWithReps:1 percentage:N(105) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(115) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(120) lift:lift]
            ]
    };

    NSMutableDictionary *setsByWeek = [[[JFTOStandardPlan new] generate:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:jokerSets[week]];
    }
    return setsByWeek;
}

- (NSArray *)deloadWeeks {
    return [[JFTOStandardPlan new] deloadWeeks];
}

- (NSArray *)incrementMaxesWeeks {
    return [[JFTOStandardPlan new] incrementMaxesWeeks];
}

- (NSArray *)weekNames {
    return [[JFTOStandardPlan new] weekNames];
}

@end