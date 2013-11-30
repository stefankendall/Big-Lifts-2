#import "SetWeightDelegate.h"

@class JSJWorkout;

@interface SJIndividualLiftViewController : UITableViewController <SetWeightDelegate>

@property(nonatomic, strong) JSJWorkout *sjWorkout;

- (IBAction)doneButtonTapped:(id)sender;
@end