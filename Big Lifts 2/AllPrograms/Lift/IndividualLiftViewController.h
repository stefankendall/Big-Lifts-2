#import "TimerObserver.h"

@class RestToolbar;

@interface IndividualLiftViewController : UITableViewController <UITableViewDelegate, TimerObserver> {
}
- (RestToolbar *)restToolbar:(UITableView *)tableView;
@end