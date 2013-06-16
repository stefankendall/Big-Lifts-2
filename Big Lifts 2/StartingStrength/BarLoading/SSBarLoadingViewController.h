#import "SSMiddleViewController.h"

@class BarLoadingDataSource;

@interface SSBarLoadingViewController : SSMiddleViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    BarLoadingDataSource *weightsTableDataSource;
}
@property(weak, nonatomic) IBOutlet UITableView *weightsTable;
@property(weak, nonatomic) UIView *overlay;

@end