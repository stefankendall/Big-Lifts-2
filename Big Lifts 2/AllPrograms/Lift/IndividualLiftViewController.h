#import "TimerObserver.h"
#import "BLTableViewController.h"

@class RestToolbar;

@interface IndividualLiftViewController : BLTableViewController <UITableViewDelegate, TimerObserver> {
}
- (RestToolbar *)restToolbar:(UITableView *)tableView;
@end