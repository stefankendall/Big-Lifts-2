#import "UITableViewController+NoEmptyRows.h"

@class JWorkoutLog;

@interface FTOEditLogViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UISwitch *deloadSwitch;
@property(nonatomic, strong) JWorkoutLog *workoutLog;
@end