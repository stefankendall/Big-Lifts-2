#import "FTOEditLiftCell.h"
#import "FTOSSTEditLiftCell.h"
#import "JFTOSSTLift.h"
#import "JFTOLift.h"

@implementation FTOSSTEditLiftCell

- (void)setLift:(JLift *)lift {
    [super setLift:lift];
    JFTOSSTLift *sstLift = (JFTOSSTLift *) lift;
    [self.associatedLiftLabel setText:sstLift.associatedLift.name];
}

@end