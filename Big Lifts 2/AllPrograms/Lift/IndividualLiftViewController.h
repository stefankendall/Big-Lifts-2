#import "TimerObserver.h"
#import "BLTableViewController.h"
#import "ShareDelegate.h"

@class RestToolbar;

@interface IndividualLiftViewController : BLTableViewController <UITableViewDelegate, TimerObserver, ShareDelegate> {
}
- (RestToolbar *)restToolbar:(UITableView *)tableView;
@end