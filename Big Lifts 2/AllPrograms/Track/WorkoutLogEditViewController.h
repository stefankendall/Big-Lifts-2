@class JWorkoutLog;

@interface WorkoutLogEditViewController : UITableViewController {}
@property(nonatomic, strong) JWorkoutLog *workoutLog;
@property (weak, nonatomic) IBOutlet UITextField *dateField;


- (void)updateWorkoutLog:(id)sender;
@end