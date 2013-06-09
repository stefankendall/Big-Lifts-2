#import <UIKit/UIKit.h>
#import "CTCustomTableViewCell.h"

@class TextFieldWithCell;

@interface TextFieldCell : CTCustomTableViewCell {
}

@property(nonatomic, strong) IBOutlet TextFieldWithCell *textField;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end