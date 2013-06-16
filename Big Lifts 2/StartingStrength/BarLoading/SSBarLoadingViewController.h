#import "SSMiddleViewController.h"

@class BarLoadingDataSource;

@interface SSBarLoadingViewController : SSMiddleViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    BarLoadingDataSource *weightsTableDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *weightsTable;

- (UIView *)findOverlay;

@end