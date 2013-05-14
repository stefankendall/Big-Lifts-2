#import "TextViewCell.h"

NSString *kCellTextView_ID = @"CellTextView_ID";

@implementation TextViewCell
@synthesize textView;

+ (TextViewCell *)createNewTextCellFromNib {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"TextViewCell" owner:self options:nil];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    TextViewCell *tCell = nil;
    NSObject *nibItem = nil;
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[TextViewCell class]]) {
            tCell = (TextViewCell *) nibItem;
            if ([tCell.reuseIdentifier isEqualToString:kCellTextView_ID])
                break;
            else
                tCell = nil;
        }
    }
    return tCell;
}


@end