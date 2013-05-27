@class WorkoutLog;

@interface WorkoutLogTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) WorkoutLog *workoutLog;
- (id)initWithWorkoutLog:(WorkoutLog *)log;
@end