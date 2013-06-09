#import "CTCustomTableViewCell.h"

@class WorkoutLog;
@class WorkoutLogTableDataSource;

@interface WorkoutLogCell : CTCustomTableViewCell {
}

@property(nonatomic) WorkoutLog *workoutLog;
@property(nonatomic, strong) WorkoutLogTableDataSource *workoutLogTableDataSource;
@property(weak, nonatomic) IBOutlet UITableView *setTable;

- (void)setWorkoutLog:(WorkoutLog *)workoutLog;
@end