@class SSWorkoutDataSource;
@class SSIndividualWorkoutDataSource;
@class SSWorkout;

@interface SSIndividualWorkoutViewController : UIViewController <UITableViewDelegate> {
}
@property(weak, nonatomic) IBOutlet UITableView *workoutTable;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@property(nonatomic, strong) SSWorkout * ssWorkout;
@property(strong, nonatomic) SSIndividualWorkoutDataSource *individualWorkoutDataSource;

@end