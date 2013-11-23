#import "FTOHeavierPlan.h"
#import "Lift.h"
#import "SetData.h"
#import "FTODeload.h"
#import "FTOStandardPlan.h"

@implementation FTOHeavierPlan

- (NSDictionary *)generate:(Lift *)lift {
    return @{
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(80) lift:lift],
                    [SetData dataWithReps:5 percentage:N(85) lift:lift amrap:YES]
            ],
            @2 : @[
                    [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(80) lift:lift],
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:3 percentage:N(90) lift:lift amrap:YES]
            ],
            @3 : @[
                    [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:3 percentage:N(85) lift:lift],
                    [SetData dataWithReps:1 percentage:N(95) lift:lift amrap:YES]
            ],
            @4 : [[FTODeload new] deloadLifts:lift]
    };
}

- (NSArray *)deloadWeeks {
    return [[FTOStandardPlan new] deloadWeeks];
}

- (NSArray *)incrementMaxesWeeks {
    return [[FTOStandardPlan new] incrementMaxesWeeks];
}

- (NSArray *)weekNames {
    return [[FTOStandardPlan new] weekNames];
}

@end