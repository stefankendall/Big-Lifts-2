#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface TextViewCell : CustomTableViewCell {
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end