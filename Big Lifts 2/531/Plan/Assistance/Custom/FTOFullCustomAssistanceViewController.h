#import "BLTableViewController.h"

@class JWorkout;
@class JFTOCustomComplexAssistanceWorkout;

@interface FTOFullCustomAssistanceViewController : BLTableViewController
@property(nonatomic, strong) JWorkout *tappedWorkout;

- (JFTOCustomComplexAssistanceWorkout *)customAssistanceWorkoutForIndexPath:(NSIndexPath *)indexPath;
@end