#import "UIViewController+ViewDeckAdditions.h"

@class SSLogDataSource;

@interface SSTrackViewController : UIViewController <UITableViewDelegate> {
    __weak IBOutlet UITableView *logTable;
    SSLogDataSource *ssLogDataSource;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end