#import "CTCustomTableViewCell.h"

@class JWorkoutLog;
@class WorkoutLogTableDataSource;

@interface WorkoutLogCell : CTCustomTableViewCell {
}

@property(nonatomic) JWorkoutLog *workoutLog;
@property(nonatomic, strong) WorkoutLogTableDataSource *workoutLogTableDataSource;
@property(weak, nonatomic) IBOutlet UITableView *setTable;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)setWorkoutLog:(JWorkoutLog *)workoutLog;
@end