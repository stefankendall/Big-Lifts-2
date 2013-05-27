#import "CustomTableViewCell.h"

@class WorkoutLog;

@interface WorkoutLogCell : CustomTableViewCell {
}

@property(nonatomic) WorkoutLog *workoutLog;
@property (weak, nonatomic) IBOutlet UITableView *workoutLogTable;

- (void)setWorkoutLog:(WorkoutLog *)workoutLog;
@end