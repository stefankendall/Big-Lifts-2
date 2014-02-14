#import "WorkoutLogCellTests.h"
#import "WorkoutLogCell.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"

@implementation WorkoutLogCellTests

- (void)testSetWorkoutSetsTableDataSource {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    WorkoutLogCell *cell = [WorkoutLogCell create];

    [cell setWorkoutLog:workoutLog];
    STAssertNotNil([[cell setTable] dataSource], @"");
}

- (void)testSetWorkoutFormatsDate {
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    NSDateComponents *comps = [NSDateComponents new];
    [comps setDay:6];
    [comps setMonth:5];
    [comps setYear:2004];
    workoutLog.date = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] dateFromComponents:comps];
    WorkoutLogCell *cell = [WorkoutLogCell create];

    [cell setWorkoutLog:workoutLog];
    STAssertEqualObjects([[cell dateLabel] text], @"5/6/04", @"");
}

@end