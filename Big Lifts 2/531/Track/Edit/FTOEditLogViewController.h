#import "UITableViewController+NoEmptyRows.h"
#import "WorkoutLogEditViewController.h"

@class JWorkoutLog;

@interface FTOEditLogViewController : WorkoutLogEditViewController {
}

@property(weak, nonatomic) IBOutlet UISwitch *deloadSwitch;
@end