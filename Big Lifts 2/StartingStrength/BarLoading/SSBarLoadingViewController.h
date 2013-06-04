#import "SSMiddleViewController.h"

@class WeightsTableDataSource;

@interface SSBarLoadingViewController : SSMiddleViewController <UIGestureRecognizerDelegate> {
    WeightsTableDataSource *weightsTableDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *weightsTable;

@end