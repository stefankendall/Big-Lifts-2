#import "TimerObserver.h"
#import "IndividualLiftViewController.h"

@class JSSWorkout;

@interface SSIndividualWorkoutViewController : IndividualLiftViewController {
}
@property(nonatomic, strong) JSSWorkout * ssWorkout;
@property(nonatomic) int workoutIndex;

- (IBAction)nextButtonTapped:(id)sender;
- (void)doneButtonTapped:(id)o;
- (void)saveState;
@end