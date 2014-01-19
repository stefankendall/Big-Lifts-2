#import "JLift.h"
#import "JSetData.h"
#import "JFTOAdvancedPlan.h"
#import "JFTOStandardPlan.h"

@implementation JFTOAdvancedPlan

- (NSDictionary *)generate:(JLift *)lift {
    return @{
            @1 : @[
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift]
            ],
            @2 : @[
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift]
            ],
            @3 : @[
                    [JSetData dataWithReps:1 percentage:N(95) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(95) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(95) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(95) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(95) lift:lift]
            ],
            @4 : @[
                    [JSetData dataWithReps:5 percentage:N(65) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(65) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(65) lift:lift]
            ]
    };
}

- (NSArray *)deloadWeeks {
    return [[JFTOStandardPlan new] deloadWeeks];
}

- (NSArray *)incrementMaxesWeeks {
    return [[JFTOStandardPlan new] incrementMaxesWeeks];
}

- (NSArray *)weekNames {
    return @[@"Week 1", @"Week 2", @"Week 3", @"Deload (opt.)"];
}

@end