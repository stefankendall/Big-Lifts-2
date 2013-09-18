@class FTOCustomWorkout;

@interface FTOCustomWorkoutViewController : UITableViewController

@property(nonatomic, strong) FTOCustomWorkout *customWorkout;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *deleteSetsButton;

- (void)addSet;
@end