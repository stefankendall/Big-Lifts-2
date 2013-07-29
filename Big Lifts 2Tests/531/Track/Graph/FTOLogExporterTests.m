#import "FTOLogExporterTests.h"
#import "FTOLogExporter.h"
#import "WorkoutLog.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "SetLogStore.h"

@implementation FTOLogExporterTests

- (void)testConvertsWorkoutLogsIntoCsv {
    WorkoutLog *workoutLog1 = [[WorkoutLogStore instance] create];
    workoutLog1.name = @"5/3/1";
    workoutLog1.date = [self dateFor:@"2013-01-23"];

    SetLog *setLog1 = [[SetLogStore instance] create];
    setLog1.weight = N(200);
    setLog1.reps = @3;
    setLog1.name = @"Deadlift";

    SetLog *setLog2 = [[SetLogStore instance] create];
    setLog2.weight = N(210);
    setLog2.reps = @2;
    setLog2.name = @"Deadlift";
    [workoutLog1.sets addObjectsFromArray:@[setLog1, setLog2]];

    WorkoutLog *workoutLog2 = [[WorkoutLogStore instance] create];
    workoutLog2.name = @"5/3/1";
    workoutLog2.date = [self dateFor:@"2013-02-01"];

    SetLog *setLog2_1 = [[SetLogStore instance] create];
    setLog2_1.weight = N(100);
    setLog2_1.reps = @5;
    setLog2_1.name = @"Press";
    [workoutLog2.sets addObject:setLog2_1];

    NSMutableString *expected = [@"name,date,weight,reps,estimated max\n" mutableCopy];
    [expected appendString:@"Press,2/1/13,100,5,116.5\n"];
    [expected appendString:@"Deadlift,1/23/13,210,2,223.86\n"];

    NSString *csv = [[FTOLogExporter new] csv];
    STAssertEqualObjects(csv, expected, @"");
}

- (NSDate *)dateFor:(NSString *)dateString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df dateFromString:dateString];
}

@end