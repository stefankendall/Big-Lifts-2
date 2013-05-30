#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@class TextFieldWithCell;

@interface TextFieldCell : CustomTableViewCell {
}

@property(nonatomic, strong) IBOutlet TextFieldWithCell *textField;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end