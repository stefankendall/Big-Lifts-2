@class SSWorkoutDataSource;
@class SSWorkoutLiftDataSource;
@class SSWorkout;

@interface SSIndividualWorkoutViewController : UIViewController {
}
@property(weak, nonatomic) IBOutlet UITableView *workoutTable;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@property(nonatomic, strong) SSWorkout * ssWorkout;
@property(strong, nonatomic) SSWorkoutLiftDataSource *workoutDataSource;

@end