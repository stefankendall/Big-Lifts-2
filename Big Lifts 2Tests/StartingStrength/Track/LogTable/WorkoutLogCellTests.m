#import "WorkoutLogCellTests.h"
#import "WorkoutLogCell.h"
#import "BLStoreManager.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"

@implementation WorkoutLogCellTests

- (void)testSetWorkoutSetsTableDataSource {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    WorkoutLogCell *cell = [WorkoutLogCell create];

    [cell setWorkoutLog:workoutLog];
    STAssertNotNil([[cell setTable] dataSource], @"");
}

- (void)testSetWorkoutFormatsDate {
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    NSDateComponents *comps = [NSDateComponents new];
    [comps setDay:6];
    [comps setMonth:5];
    [comps setYear:2004];
    workoutLog.date = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] dateFromComponents:comps];
    WorkoutLogCell *cell = [WorkoutLogCell create];

    [cell setWorkoutLog:workoutLog];
    STAssertEqualObjects([[cell dateLabel] text], @"05/06", @"");

}

@end