#import "JSetData.h"
#import "JFTOStandardPlan.h"
#import "JFTOFirstSetLastMultipleSetsPlan.h"

@implementation JFTOFirstSetLastMultipleSetsPlan
- (NSDictionary *)generate:(JLift *)lift {
    NSDictionary *firstSetLastSets = @{
            @1 : @[
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(65) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(65) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(65) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(65) lift:lift optional:YES],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(65) lift:lift optional:YES]
            ],
            @2 : @[
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(70) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(70) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(70) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(70) lift:lift optional:YES],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(70) lift:lift optional:YES]
            ],
            @3 : @[
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(75) lift:lift optional:YES],
                    [JSetData dataWithReps:5 maxReps:8 percentage:N(75) lift:lift optional:YES]
            ]
    };

    NSMutableDictionary *setsByWeek = [[[JFTOStandardPlan new] generate:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:firstSetLastSets[week]];
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