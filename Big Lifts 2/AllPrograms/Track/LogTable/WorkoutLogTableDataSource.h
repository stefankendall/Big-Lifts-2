@class JWorkoutLog;

extern const int SETS_SECTION;
extern const int ESTIMATED_MAX_SECTION;

@interface WorkoutLogTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) JWorkoutLog *workoutLog;

- (id)initWithWorkoutLog:(JWorkoutLog *)log;

- (UITableViewCell *)maxEstimateCell: (UITableView *)tableView;

- (UITableViewCell *)deloadCell:(UITableView *)tableView;

@end