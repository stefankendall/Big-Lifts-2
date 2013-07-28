#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class BarLoadingDataSource;
@class PurchaseOverlay;

@interface BarLoadingViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    BarLoadingDataSource *weightsTableDataSource;
}
@property(weak, nonatomic) IBOutlet UITableView *weightsTable;

@end