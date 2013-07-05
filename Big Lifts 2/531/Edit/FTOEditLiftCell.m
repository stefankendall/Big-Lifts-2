#import "FTOEditLiftCell.h"
#import "TextViewInputAccessoryBuilder.h"
#import "FTOLift.h"
#import "RowTextField.h"

@implementation FTOEditLiftCell

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.max];
}

- (void)setLift:(FTOLift *)lift {
    [[self liftName] setText:lift.name];
    if ([lift.weight doubleValue] > 0) {
        [[self max] setText:[lift.weight stringValue]];
    }
}
@end