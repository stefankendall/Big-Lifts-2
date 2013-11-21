@class WorkoutLog;

extern const int SETS_SECTION;
extern const int ESTIMATED_MAX_SECTION;

@interface WorkoutLogTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) WorkoutLog *workoutLog;

- (id)initWithWorkoutLog:(WorkoutLog *)log;

- (UITableViewCell *)maxEstimateCell: (UITableView *)tableView;
@end