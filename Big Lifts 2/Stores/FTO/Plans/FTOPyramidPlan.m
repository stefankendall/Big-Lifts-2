#import "FTOPyramidPlan.h"
#import "Lift.h"
#import "FTOStandardPlan.h"
#import "SetData.h"

@implementation FTOPyramidPlan
- (NSDictionary *)generate:(Lift *)lift {
    NSDictionary *pyramidSets = @{
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(65) lift:lift amrap:YES]
            ],
            @2 : @[
                    [SetData dataWithReps:3 percentage:N(80) lift:lift],
                    [SetData dataWithReps:3 percentage:N(70) lift:lift amrap:YES]
            ],
            @3 : @[
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift amrap:YES]
            ]
    };

    NSMutableDictionary *setsByWeek = [[[FTOStandardPlan new] generate:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:pyramidSets[week]];
    }
    return setsByWeek;
}

@end