#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@class JSSWorkout;
@class RateDialog;

@interface SSLiftViewController : BLTableViewController {
}
@property(nonatomic, strong) JSSWorkout *ssWorkout;
@property(nonatomic) BOOL aWorkout;

@property(nonatomic, strong) RateDialog *rateDialog;

- (void)switchWorkout;
@end