@class JFTOCustomAssistanceWorkout;
@class JSet;

@interface FTOCustomAssistanceWorkoutViewController : UITableViewController
@property(nonatomic, strong) JFTOCustomAssistanceWorkout *customAssistanceWorkout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property(nonatomic) JSet *tappedSet;
@end