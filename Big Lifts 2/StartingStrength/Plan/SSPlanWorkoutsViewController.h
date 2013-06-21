#import "UIViewController+ViewDeckAdditions.h"
#import "UITableViewController+NoEmptyRows.h"

@class SSWorkout;

@interface SSPlanWorkoutsViewController : UITableViewController
@property(weak, nonatomic) IBOutlet UIBarButtonItem *variantButton;

- (SSWorkout *)getWorkoutForSection:(int)section;
@end