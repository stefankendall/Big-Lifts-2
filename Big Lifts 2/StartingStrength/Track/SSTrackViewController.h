#import "SSMiddleViewController.h"

@class SSLogDataSource;

@interface SSTrackViewController : SSMiddleViewController <UITableViewDelegate> {
    __weak IBOutlet UITableView *logTable;
    SSLogDataSource *ssLogDataSource;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end