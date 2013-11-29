#import "WorkoutLogCell.h"
#import "JWorkoutLog.h"
#import "WorkoutLogTableDataSource.h"

@implementation WorkoutLogCell
@synthesize workoutLog;

- (void)setWorkoutLog:(JWorkoutLog *)workoutLog1 {
    workoutLog = workoutLog1;

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateLabel setText:[dateFormatter stringFromDate:self.workoutLog.date]];

    self.workoutLogTableDataSource = [[WorkoutLogTableDataSource alloc] initWithWorkoutLog:self.workoutLog];
    [self.setTable setDataSource:self.workoutLogTableDataSource];
    [self.setTable setDelegate:self.workoutLogTableDataSource];
}

@end