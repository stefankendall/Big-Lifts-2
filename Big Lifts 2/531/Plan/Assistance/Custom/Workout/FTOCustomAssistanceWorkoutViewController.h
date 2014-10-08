#import "BLTableViewController.h"

@class JFTOCustomAssistanceWorkout;
@class JSet;
@class JWorkout;

@interface FTOCustomAssistanceWorkoutViewController : BLTableViewController
@property(nonatomic, strong) JWorkout *workout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property(nonatomic) JSet *tappedSet;
@end