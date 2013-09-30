@class SSWorkout;

@interface SSIndividualWorkoutViewController : UITableViewController <UITableViewDelegate> {
}
@property(nonatomic, strong) SSWorkout * ssWorkout;
@property(nonatomic) int workoutIndex;

- (IBAction)nextButtonTapped:(id)sender;
- (void)doneButtonTapped:(id)o;
- (void)saveState;
@end