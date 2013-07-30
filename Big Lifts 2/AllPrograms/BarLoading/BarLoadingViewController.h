#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class BarLoadingDataSource;
@class PurchaseOverlay;

@interface BarLoadingViewController : UITableViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    BarLoadingDataSource *weightsTableDataSource;
}
@end