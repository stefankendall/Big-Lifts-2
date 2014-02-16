#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@class JSSWorkout;

@interface SSLiftViewController : BLTableViewController {
}
@property(nonatomic, strong) JSSWorkout *ssWorkout;
@property(nonatomic) BOOL aWorkout;

- (void)switchWorkout;
@end