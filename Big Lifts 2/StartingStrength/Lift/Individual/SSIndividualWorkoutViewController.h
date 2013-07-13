@class SSIndividualWorkoutDataSource;
@class SSWorkout;

@interface SSIndividualWorkoutViewController : UIViewController <UITableViewDelegate> {
}
@property(weak, nonatomic) IBOutlet UITableView *workoutTable;

@property(nonatomic, strong) SSWorkout * ssWorkout;
@property(nonatomic) int workoutIndex;
@property(strong, nonatomic) SSIndividualWorkoutDataSource *individualWorkoutDataSource;

- (IBAction)nextButtonTapped:(id)sender;
- (void)doneButtonTapped:(id)o;

- (void)saveState;
@end