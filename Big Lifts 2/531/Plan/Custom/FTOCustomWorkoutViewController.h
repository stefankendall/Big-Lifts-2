@class JFTOCustomWorkout;

@interface FTOCustomWorkoutViewController : UITableViewController

@property(nonatomic, strong) JFTOCustomWorkout *customWorkout;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *deleteSetsButton;

- (void)addSet;
@end