#import <UIKit/UIKit.h>

extern NSString *kCellTextView_ID;

@interface TextViewCell : UITableViewCell {
    IBOutlet UITextView *textView;
}

@property(nonatomic, retain) UITextView *textView;
@end