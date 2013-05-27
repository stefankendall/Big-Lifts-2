#import "WorkoutLogCell.h"
#import "WorkoutLog.h"
#import "WorkoutLogTableDataSource.h"

@implementation WorkoutLogCell
@synthesize workoutLog, setTable, workoutLogTableDataSource;

- (void)setWorkoutLog:(WorkoutLog *)workoutLog1 {
    workoutLog = workoutLog1;

    workoutLogTableDataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog: workoutLog];
    [setTable setDataSource:workoutLogTableDataSource];
    [setTable setDelegate:workoutLogTableDataSource];
}

@end