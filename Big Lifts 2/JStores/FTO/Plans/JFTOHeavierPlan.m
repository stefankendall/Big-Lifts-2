#import "JFTOHeavierPlan.h"
#import "JSetData.h"
#import "JFTOStandardPlan.h"
#import "JFTODeload.h"

@implementation JFTOHeavierPlan

- (NSDictionary *)generate:(JLift *)lift {
    return @{
            @1 : @[
                    [JSetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(80) lift:lift],
                    [JSetData dataWithReps:5 percentage:N(85) lift:lift amrap:YES]
            ],
            @2 : @[
                    [JSetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:3 percentage:N(80) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(90) lift:lift amrap:YES]
            ],
            @3 : @[
                    [JSetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [JSetData dataWithReps:5 percentage:N(75) lift:lift],
                    [JSetData dataWithReps:3 percentage:N(85) lift:lift],
                    [JSetData dataWithReps:1 percentage:N(95) lift:lift amrap:YES]
            ],
            @4 : [[JFTODeload new] deloadLifts:lift]
    };
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