#import "FTODeload.h"
#import "SetData.h"
#import "FTOLift.h"

@implementation FTODeload

- (NSArray *)deloadLifts:(FTOLift *)lift {
    return @[
            [SetData dataWithReps:5 percentage:N(40) lift:lift],
            [SetData dataWithReps:5 percentage:N(50) lift:lift],
            [SetData dataWithReps:5 percentage:N(60) lift:lift]
    ];
}

@end