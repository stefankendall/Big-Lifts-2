#import "TimerObserver.h"

@class JSSWorkout;

@interface SSIndividualWorkoutViewController : UITableViewController <UITableViewDelegate, TimerObserver> {
}
@property(nonatomic, strong) JSSWorkout * ssWorkout;
@property(nonatomic) int workoutIndex;

- (IBAction)nextButtonTapped:(id)sender;
- (void)doneButtonTapped:(id)o;
- (void)saveState;
@end