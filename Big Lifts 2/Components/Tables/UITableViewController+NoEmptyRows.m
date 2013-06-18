#import "UITableViewController+NoEmptyRows.h"

@implementation UIViewController (NoEmptyRows)
- (UIView *) emptyView {
    UIView *emptyViewToPreventEmptyRows = [UIView new];
    return emptyViewToPreventEmptyRows;
}
@end