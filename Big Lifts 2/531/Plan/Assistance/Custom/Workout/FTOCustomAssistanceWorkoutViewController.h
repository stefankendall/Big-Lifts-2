@class JFTOCustomAssistanceWorkout;
@class JSet;
@class JWorkout;

@interface FTOCustomAssistanceWorkoutViewController : UITableViewController
@property(nonatomic, strong) JWorkout *workout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property(nonatomic) JSet *tappedSet;
@end