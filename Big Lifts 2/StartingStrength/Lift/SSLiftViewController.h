#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class JSSWorkout;

@interface SSLiftViewController : UITableViewController {
}
@property(nonatomic, strong) JSSWorkout *ssWorkout;
@property(nonatomic) BOOL aWorkout;

- (void)switchWorkout;
@end