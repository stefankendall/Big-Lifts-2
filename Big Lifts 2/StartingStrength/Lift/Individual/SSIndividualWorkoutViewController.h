#import "TimerObserver.h"
#import "IndividualLiftViewController.h"
#import "SetChangeDelegate.h"

@class JSSWorkout;
@class JSet;

@interface SSIndividualWorkoutViewController : IndividualLiftViewController <SetChangeDelegate> {
}
@property(nonatomic, strong) JSSWorkout * ssWorkout;
@property(nonatomic) int workoutIndex;

@property(nonatomic, strong) JSet *tappedSet;

- (void)resetLoggedSets;

- (IBAction)nextButtonTapped:(id)sender;
- (void)doneButtonTapped:(id)o;
- (void)saveState;

- (void)logWorkout;
@end