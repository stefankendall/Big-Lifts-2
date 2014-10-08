#import "UITableViewController+NoEmptyRows.h"
#import "BLTableViewController.h"

@class JWorkoutLog;

@interface FTOEditLogViewController : BLTableViewController
@property(weak, nonatomic) IBOutlet UITextField *dateField;
@property(weak, nonatomic) IBOutlet UISwitch *deloadSwitch;
@property(nonatomic, strong) JWorkoutLog *workoutLog;
@end