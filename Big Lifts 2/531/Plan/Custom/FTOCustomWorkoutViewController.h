@class FTOCustomWorkout;

@interface FTOCustomWorkoutViewController : UITableViewController

@property(nonatomic, strong) FTOCustomWorkout *customWorkout;

- (IBAction)addSet:(id)sender;
@end