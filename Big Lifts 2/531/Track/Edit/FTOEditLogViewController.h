#import "UITableViewController+NoEmptyRows.h"

@class WorkoutLog;

@interface FTOEditLogViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UISwitch *deloadSwitch;
@property(nonatomic, strong) WorkoutLog *workoutLog;
@end