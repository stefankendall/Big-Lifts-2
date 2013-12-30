#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class JSSWorkout;
@class RateDialog;

@interface SSLiftViewController : UITableViewController {
}
@property(nonatomic, strong) JSSWorkout *ssWorkout;
@property(nonatomic) BOOL aWorkout;

@property(nonatomic, strong) RateDialog *rateDialog;

- (void)switchWorkout;
@end