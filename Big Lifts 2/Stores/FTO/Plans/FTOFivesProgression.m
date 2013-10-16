#import "FTOFivesProgression.h"
#import "Lift.h"
#import "SetData.h"
#import "FTODeload.h"

@implementation FTOFivesProgression

- (NSDictionary *)generate:(Lift *)lift {
    return @{
            @1 : @[
                    [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(65) lift:lift],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(85) lift:lift]
            ],
            @2 : @[
                    [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(70) lift:lift],
                    [SetData dataWithReps:5 percentage:N(80) lift:lift],
                    [SetData dataWithReps:5 percentage:N(90) lift:lift]
            ],
            @3 : @[
                    [SetData dataWithReps:5 percentage:N(40) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(50) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:3 percentage:N(60) lift:lift amrap:NO warmup:YES],
                    [SetData dataWithReps:5 percentage:N(75) lift:lift],
                    [SetData dataWithReps:5 percentage:N(85) lift:lift],
                    [SetData dataWithReps:5 percentage:N(95) lift:lift]
            ],
            @4 : [[FTODeload new] deloadLifts:(id) lift]
    };
}

- (NSArray *)deloadWeeks {
    return @[@4];
}

@end