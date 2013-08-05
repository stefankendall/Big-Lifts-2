#import "FTOChangeLiftCell.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation FTOChangeLiftCell

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:(id) self.textField];
}

@end