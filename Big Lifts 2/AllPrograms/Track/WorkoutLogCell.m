#import "WorkoutLogCell.h"
#import "WorkoutLog.h"
#import "WorkoutLogTableDataSource.h"

@implementation WorkoutLogCell
@synthesize workoutLog;

- (void)setWorkoutLog:(WorkoutLog *)workoutLog1 {
    workoutLog = workoutLog1;

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM/dd"];
    [self.dateLabel setText:[dateFormatter stringFromDate:self.workoutLog.date]];

    self.workoutLogTableDataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:self.workoutLog];
    [self.setTable setDataSource:self.workoutLogTableDataSource];
    [self.setTable setDelegate:self.workoutLogTableDataSource];
}

@end