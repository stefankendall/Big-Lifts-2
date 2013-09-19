#import "FTOCustomWeekEditCell.h"
#import "RowTextField.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOCustomWeekEditCell

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.nameField];
}

@end