#import "BLTableViewController.h"

@class JFTOCustomWorkout;

@interface FTOCustomWorkoutViewController : BLTableViewController

@property(nonatomic, strong) JFTOCustomWorkout *customWorkout;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *deleteSetsButton;

- (void)addSet;
@end