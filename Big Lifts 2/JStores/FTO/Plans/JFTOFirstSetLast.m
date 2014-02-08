#import "JLift.h"
#import "JSetData.h"
#import "JFTOStandardPlan.h"
#import "JFTOFirstSetLast.h"

@implementation JFTOFirstSetLast
- (NSDictionary *)generate:(JLift *)lift {
    NSDictionary *pyramidSets = @{
            @1 : @[
                    [JSetData dataWithReps:5 percentage:N(65) lift:lift amrap:YES]
            ],
            @2 : @[
                    [JSetData dataWithReps:3 percentage:N(70) lift:lift amrap:YES]
            ],
            @3 : @[
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift amrap:YES]
            ]
    };

    NSMutableDictionary *setsByWeek = [[[JFTOStandardPlan new] generate:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:pyramidSets[week]];
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