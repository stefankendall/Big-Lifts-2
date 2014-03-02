#import "BLTableViewController.h"
#import "AssistanceCopyDelegate.h"

@class JFTOCustomAssistanceWorkout;
@class JWorkout;

@interface FTOCustomAssistanceViewController : BLTableViewController <AssistanceCopyDelegate>
@property(nonatomic, strong) JWorkout *tappedWorkout;
@end