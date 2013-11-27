#import "JSetData.h"
#import "JFTOLift.h"
#import "JFTODeload.h"

@implementation JFTODeload

- (NSArray *)deloadLifts:(JFTOLift *)lift {
    return @[
            [JSetData dataWithReps:5 percentage:N(40) lift:lift],
            [JSetData dataWithReps:5 percentage:N(50) lift:lift],
            [JSetData dataWithReps:5 percentage:N(60) lift:lift]
    ];
}

@end