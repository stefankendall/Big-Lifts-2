#import "TimerObserver.h"
#import "BLTableViewController.h"
#import "ShareDelegate.h"

@class RestShareToolbar;

@interface IndividualLiftViewController : BLTableViewController <UITableViewDelegate, TimerObserver, ShareDelegate> {
}
- (RestShareToolbar *)restToolbar:(UITableView *)tableView;
@end