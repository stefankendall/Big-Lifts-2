#import "FTOLogGraphTransformerTests.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "JSetLogStore.h"
#import "FTOLogGraphTransformer.h"

@implementation FTOLogGraphTransformerTests

- (void)testLogToChartEntry {
    JSetLog *set = [[JSetLogStore instance] create];
    set.weight = N(200);
    set.reps = @3;
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    [workoutLog.sets addObjectsFromArray:@[set]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    workoutLog.date = [df dateFromString:@"2013-01-12"];

    NSDictionary *chartEntry = [[FTOLogGraphTransformer new] logToChartEntry:workoutLog withSet:set];
    NSDictionary *expected = @{
            @"date" : @{
                    @"year" : @2013,
                    @"month" : @1,
                    @"day" : @12
            },
            @"weight" : N(220)
    };
    STAssertEqualObjects(chartEntry, expected, @"");
}

- (void)testHandlesNilWeightAndReps {
    JSetLog *set = [[JSetLogStore instance] create];
    set.weight = nil;
    set.reps = nil;
    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    [workoutLog.sets addObjectsFromArray:@[set]];
    workoutLog.date = [NSDate new];

    NSDictionary *chartEntry = [[FTOLogGraphTransformer new] logToChartEntry:workoutLog withSet:set];
    STAssertEqualObjects(chartEntry[@"weight"], N(0), @"");
}

- (void)testLogEntriesFromChartAddsObjectIfMissing {
    NSMutableArray *chartData = [@[
            @{@"name" : @"Press", @"data" : @[@{}]}
    ] mutableCopy];
    NSMutableArray *deadLiftData = [[FTOLogGraphTransformer new] logEntriesFromChart:chartData forName:@"Deadlift"];
    STAssertEquals((int)[chartData count], 2, @"");
    STAssertNotNil(deadLiftData, @"");

    NSMutableArray *pressData = [[FTOLogGraphTransformer new] logEntriesFromChart:chartData forName:@"Press"];
    STAssertEquals((int)[pressData count], 1, @"");
}

- (void)testGeneratesOneLogPerWorkout {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = @"Deadlift";
    set1.weight = N(200);
    set1.reps = @3;

    JSetLog *set2 = [[JSetLogStore instance] create];
    set1.name = @"Deadlift";
    set1.weight = N(210);
    set1.reps = @2;

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    workoutLog.date = [df dateFromString:@"2013-01-12"];
    [workoutLog.sets addObjectsFromArray:@[set1, set2]];

    NSArray *chartData = [[FTOLogGraphTransformer new] buildDataFromLog];
    NSArray *expected = @[@{
            @"name" : @"Deadlift",
            @"data" : @[
                    @{@"weight" : N(224), @"date" : @{@"year" : @2013, @"month" : @1, @"day" : @12}}
            ]
    }];
    STAssertEqualObjects(chartData, expected, [NSString stringWithFormat:@"%@", chartData]);
}

- (void)testDoesNotIncludeDeload {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = @"Deadlift";
    set1.weight = N(200);
    set1.reps = @3;

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.deload = YES;
    workoutLog.name = @"5/3/1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    workoutLog.date = [df dateFromString:@"2013-01-12"];

    [workoutLog addSet:set1];
    NSArray *chartData = [[FTOLogGraphTransformer new] buildDataFromLog];
    STAssertEqualObjects(chartData, @[], @"");
}

- (void)testDoesNotLeaveBlankEntriesInTheLog {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = nil;
    set1.weight = N(200);
    set1.reps = @1;

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    workoutLog.date = [df dateFromString:@"2013-01-12"];

    [workoutLog addSet:set1];
    NSArray *chartData = [[FTOLogGraphTransformer new] buildDataFromLog];
    STAssertEqualObjects(chartData, @[], @"");
}

@end