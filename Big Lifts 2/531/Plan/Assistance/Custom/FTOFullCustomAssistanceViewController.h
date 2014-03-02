#import "BLTableViewController.h"
#import "AssistanceCopyDelegate.h"

@class JWorkout;
@class JFTOFullCustomAssistanceWorkout;

@interface FTOFullCustomAssistanceViewController : BLTableViewController <AssistanceCopyDelegate>
@property(nonatomic, strong) JWorkout *tappedWorkout;

- (JFTOFullCustomAssistanceWorkout *)customAssistanceWorkoutForIndexPath:(NSIndexPath *)indexPath;
@end