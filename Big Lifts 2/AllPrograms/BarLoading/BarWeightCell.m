#import "BarWeightCell.h"
#import "TextViewInputAccessoryBuilder.h"

@implementation BarWeightCell

- (void)awakeFromNib {
    [[TextViewInputAccessoryBuilder new] doneButtonAccessory:self.textField];
}

@end