#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@class TextViewWithCell;

@interface TextViewCell : CustomTableViewCell {
}

@property(nonatomic, strong) IBOutlet TextViewWithCell *textView;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end