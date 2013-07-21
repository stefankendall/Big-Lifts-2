#import "FTOFirstSetLastMultipleSetsPlan.h"
#import "Lift.h"
#import "FTOStandardPlan.h"
#import "SetData.h"

@implementation FTOFirstSetLastMultipleSetsPlan
- (NSDictionary *)generate:(Lift *)lift {
    NSDictionary *firstSetLastSets = @{
            @1 : @[
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(65) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(65) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(65) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(65) lift:lift optional: YES],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(65) lift:lift optional: YES]
            ],
            @2 : @[
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(70) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(70) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(70) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(70) lift:lift optional: YES],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(70) lift:lift optional: YES]
            ],
            @3 : @[
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(75) lift:lift optional: YES],
                    [SetData dataWithReps:5 maxReps: 8 percentage:N(75) lift:lift optional: YES]
            ]
    };

    NSMutableDictionary *setsByWeek = [[[FTOStandardPlan new] generate:lift] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSNumber *week = [NSNumber numberWithInt:i];
        NSArray *sets = setsByWeek[week];
        setsByWeek[week] = [sets arrayByAddingObjectsFromArray:firstSetLastSets[week]];
    }
    return setsByWeek;
}
@end