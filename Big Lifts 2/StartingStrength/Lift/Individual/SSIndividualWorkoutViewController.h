@class JSSWorkout;

@interface SSIndividualWorkoutViewController : UITableViewController <UITableViewDelegate> {
}
@property(nonatomic, strong) JSSWorkout * ssWorkout;
@property(nonatomic) int workoutIndex;

- (IBAction)nextButtonTapped:(id)sender;
- (void)doneButtonTapped:(id)o;
- (void)saveState;
@end