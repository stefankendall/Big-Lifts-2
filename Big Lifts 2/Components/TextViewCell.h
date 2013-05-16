#import <UIKit/UIKit.h>

extern NSString *kCellTextView_ID;

@interface TextViewCell : UITableViewCell {
}

+ (TextViewCell*) createNewTextCellFromNib;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end