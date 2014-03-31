#import "FTOLiftsIncrementingCell.h"
#import "JFTOLift.h"

@implementation FTOLiftsIncrementingCell

- (void)setLift:(JFTOLift *)lift{
    [self.liftName setText:lift.name];
    [self.increment setText:[NSString stringWithFormat: @"+%@", lift.increment]];
    [self.endWeight setText:[NSString stringWithFormat:@"%@", lift.weight]];
}

@end