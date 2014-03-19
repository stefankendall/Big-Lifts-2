@class JFTOFullCustomWorkout;
@class JSet;

@interface FTOFullCustomWorkoutViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property(nonatomic) JFTOFullCustomWorkout *customWorkout;
@property(nonatomic, strong) JSet *tappedSet;
@end