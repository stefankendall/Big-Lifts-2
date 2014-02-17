#import "SetWeightDelegate.h"
#import "IndividualLiftViewController.h"

@class JSJWorkout;

@interface SJIndividualLiftViewController : IndividualLiftViewController <SetWeightDelegate>

@property(nonatomic, strong) JSJWorkout *sjWorkout;

- (IBAction)doneButtonTapped:(id)sender;
@end