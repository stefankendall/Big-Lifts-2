#import "SetWeightDelegate.h"

@class SJWorkout;

@interface SJIndividualLiftViewController : UITableViewController <SetWeightDelegate>

@property(nonatomic, strong) SJWorkout *sjWorkout;

- (IBAction)doneButtonTapped:(id)sender;
@end