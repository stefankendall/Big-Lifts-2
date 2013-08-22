#import "FTOEditLiftCell.h"
#import "FTOSSTEditLiftCell.h"
#import "FTOSSTLift.h"

@implementation FTOSSTEditLiftCell

- (void)setLift:(Lift *)lift {
    [super setLift:lift];
    FTOSSTLift *sstLift = (FTOSSTLift *) lift;
    [self.associatedLiftLabel setText:sstLift.associatedLift.name];
}

@end