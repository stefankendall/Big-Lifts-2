#import "FTOJokerPlan.h"
#import "Lift.h"
#import "FTOStandardPlan.h"
#import "SetData.h"

@implementation FTOJokerPlan
- (NSDictionary *)generate:(Lift *)lift {
    NSDictionary *jokerSets = @{
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(95) lift:lift],
                    [SetData dataWithReps:5 percentage:N(105) lift:lift],
                    [SetData dataWithReps:2 percentage:N(110) lift:lift]
            ],
            @2 : @[
                    [SetData dataWithReps:3 percentage:N(100) lift:lift],
                    [SetData dataWithReps:3 percentage:N(105) lift:lift],
                    [SetData dataWithReps:1 percentage:N(115) lift:lift]
            ],
            @3 : @[
                    [SetData dataWithReps:1 percentage:N(105) lift:lift],
                    [SetData dataWithReps:1 percentage:N(115) lift:lift],
                    [SetData dataWithReps:1 percentage:N(120) lift:lift]
            ]
    };

    NSMutableDictionary *setsByWeek = [[[FTOStandardPlan new] generate:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:jokerSets[week]];
    }
    return setsByWeek;
}

@end