@class SSWorkoutDataSource;
@class SSWorkoutLiftDataSource;

@interface SSWorkoutViewController : UIViewController {
}
@property(weak, nonatomic) IBOutlet UITableView *workoutTable;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@property(strong, nonatomic) SSWorkoutLiftDataSource *workoutDataSource;

@end