#import "FTOStandardPlan.h"
#import "Lift.h"
#import "SetData.h"

@implementation FTOStandardPlan

- (NSDictionary *)generate:(Lift *)lift {
    NSArray *week1Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(65) lift:lift],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:5 percentage:N(85) lift:lift amrap:YES]
    ];

    NSArray *week2Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(70) lift:lift],
            [SetData dataWithReps:3 percentage:N(80) lift:lift],
            [SetData dataWithReps:3 percentage:N(90) lift:lift amrap:YES]
    ];

    NSArray *week3Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(75) lift:lift],
            [SetData dataWithReps:3 percentage:N(85) lift:lift],
            [SetData dataWithReps:1 percentage:N(95) lift:lift amrap:YES]
    ];

    NSArray *week4Lifts = @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(60) lift:lift amrap:NO warmup:YES],
            [SetData dataWithReps:5 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift]
    ];

    NSDictionary *fresherTemplate = @{
            @1 : week1Lifts,
            @2 : week2Lifts,
            @3 : week3Lifts,
            @4 : week4Lifts
    };
    return fresherTemplate;
}

@end