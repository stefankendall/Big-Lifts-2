#import "UIViewController+ViewDeckAdditions.h"

@class SSWorkout;

@interface SSLiftViewController : UITableViewController {
}
@property(nonatomic, strong) SSWorkout *ssWorkout;

- (void)switchWorkout;
@end