#import "FTOLiftWorkoutToolbar.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOLiftWorkoutToolbar

- (void)awakeFromNib {
    [super awakeFromNib];
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.repsField];
}


@end