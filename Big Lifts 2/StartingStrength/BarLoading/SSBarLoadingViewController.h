#import "SSMiddleViewController.h"

@class WeightsTableDataSource;

@interface SSBarLoadingViewController : SSMiddleViewController <UIGestureRecognizerDelegate, UITableViewDelegate> {
    WeightsTableDataSource *weightsTableDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *weightsTable;

@end