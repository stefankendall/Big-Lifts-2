#import "UIViewController+ViewDeckAdditions.h"

@class BarLoadingDataSource;

@interface SSBarLoadingViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    BarLoadingDataSource *weightsTableDataSource;
}
@property(weak, nonatomic) IBOutlet UITableView *weightsTable;
@property(weak, nonatomic) UIView *overlay;

@end