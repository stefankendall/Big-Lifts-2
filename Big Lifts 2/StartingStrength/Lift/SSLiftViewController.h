#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class SSWorkout;

@interface SSLiftViewController : UITableViewController {
}
@property(nonatomic, strong) SSWorkout *ssWorkout;
@property(nonatomic) BOOL aWorkout;

- (void)switchWorkout;
@end