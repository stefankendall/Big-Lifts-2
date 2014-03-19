@class JFTOFullCustomWorkout;
@class JSet;

@interface FTOFullCustomWorkoutViewController : UITableViewController

@property(nonatomic) JFTOFullCustomWorkout *customWorkout;
@property(nonatomic, strong) JSet *tappedSet;
@end