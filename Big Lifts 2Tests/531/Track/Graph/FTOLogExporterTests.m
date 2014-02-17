#import "FTOLogExporterTests.h"
#import "FTOLogExporter.h"
#import "JWorkoutLog.h"
#import "JWorkoutLogStore.h"
#import "JSetLog.h"
#import "JSetLogStore.h"

@implementation FTOLogExporterTests

- (void)testConvertsWorkoutLogsIntoCsv {
    JWorkoutLog *workoutLog1 = [[JWorkoutLogStore instance] create];
    workoutLog1.name = @"5/3/1";
    workoutLog1.date = [self dateFor:@"2013-01-23"];

    JSetLog *setLog1 = [[JSetLogStore instance] create];
    setLog1.weight = N(200);
    setLog1.reps = @3;
    setLog1.name = @"Deadlift";

    JSetLog *setLog2 = [[JSetLogStore instance] create];
    setLog2.weight = N(210);
    setLog2.reps = @2;
    setLog2.name = @"Deadlift";
    [workoutLog1.sets addObjectsFromArray:@[setLog1, setLog2]];

    JWorkoutLog *workoutLog2 = [[JWorkoutLogStore instance] create];
    workoutLog2.name = @"5/3/1";
    workoutLog2.date = [self dateFor:@"2013-02-01"];

    JSetLog *setLog2_1 = [[JSetLogStore instance] create];
    setLog2_1.weight = N(100);
    setLog2_1.reps = @5;
    setLog2_1.name = @"Press";
    [workoutLog2 addSet:setLog2_1];

    NSMutableString *expected = [@"name,date,weight,reps,estimated max\n" mutableCopy];
    [expected appendString:@"Press,2/1/13,100,5,116.7\n"];
    [expected appendString:@"Deadlift,1/23/13,210,2,224\n"];

    NSString *csv = [[FTOLogExporter new] csv];
    STAssertEqualObjects(csv, expected, @"");
}

- (void)testDoesNotCrashForNilLiftName {
    JWorkoutLog *workoutLog1 = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:[NSDate new]];
    JSetLog *setLog1 = [[JSetLogStore instance] create];
    [workoutLog1 addSet:setLog1];
    [[FTOLogExporter new] csv];
}

- (NSDate *)dateFor:(NSString *)dateString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df dateFromString:dateString];
}

@end