#import "BLTableViewController.h"

@class JWorkout;
@class JFTOFullCustomAssistanceWorkout;

@interface FTOFullCustomAssistanceViewController : BLTableViewController
@property(nonatomic, strong) JWorkout *tappedWorkout;

- (JFTOFullCustomAssistanceWorkout *)customAssistanceWorkoutForIndexPath:(NSIndexPath *)indexPath;
@end