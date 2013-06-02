#import "SSMiddleViewController.h"

@class WeightsTableDataSource;

@interface SSBarLoadingViewController : SSMiddleViewController
{
    WeightsTableDataSource *weightsTableDataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *weightsTable;

@end