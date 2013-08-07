#import "FTOAdvancedPlan.h"
#import "Lift.h"
#import "SetData.h"

@implementation FTOAdvancedPlan

- (NSDictionary *)generate:(Lift *)lift {
    return @{
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift]
            ],
            @2 : @[
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:3 percentage:N(85) lift:lift]
            ],
            @3 : @[
                    [SetData dataWithReps:1 percentage:N(95) lift:lift],
                    [SetData dataWithReps:1 percentage:N(95) lift:lift],
                    [SetData dataWithReps:1 percentage:N(95) lift:lift],
                    [SetData dataWithReps:1 percentage:N(95) lift:lift],
                    [SetData dataWithReps:1 percentage:N(95) lift:lift]
            ],
            @4 : @[
                    [SetData dataWithReps:5 percentage:N(65) lift:lift],
                    [SetData dataWithReps:5 percentage:N(65) lift:lift],
                    [SetData dataWithReps:5 percentage:N(65) lift:lift]
            ]
    };
}

@end