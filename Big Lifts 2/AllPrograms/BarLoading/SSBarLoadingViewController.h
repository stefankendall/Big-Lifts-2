#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class BarLoadingDataSource;
@class PurchaseOverlay;

@interface SSBarLoadingViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    BarLoadingDataSource *weightsTableDataSource;
}
@property(weak, nonatomic) IBOutlet UITableView *weightsTable;
@property(weak, nonatomic) PurchaseOverlay *overlay;

@end