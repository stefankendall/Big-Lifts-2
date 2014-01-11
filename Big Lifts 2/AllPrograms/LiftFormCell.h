#import "TextFieldCell.h"

@class PaddingRowTextField;

@interface LiftFormCell : CTCustomTableViewCell
{}
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet PaddingRowTextField *textField;

@end

