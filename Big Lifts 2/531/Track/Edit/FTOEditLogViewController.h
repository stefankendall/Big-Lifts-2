#import "UITableViewController+NoEmptyRows.h"

@class WorkoutLog;

@interface FTOEditLogViewController : UITableViewController {}
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property(nonatomic, strong) WorkoutLog *workoutLog;
@end