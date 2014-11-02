@class JWorkoutLog;

@interface WorkoutLogEditViewController : UITableViewController {}
@property(nonatomic, strong) JWorkoutLog *workoutLog;
@property (weak, nonatomic) IBOutlet UITextField *dateField;


@end