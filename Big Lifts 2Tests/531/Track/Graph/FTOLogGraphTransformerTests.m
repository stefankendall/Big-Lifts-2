#import "FTOLogGraphTransformerTests.h"
#import "WorkoutLogStore.h"
#import "WorkoutLog.h"
#import "SetLog.h"
#import "SetLogStore.h"
#import "FTOLogGraphTransformer.h"

@implementation FTOLogGraphTransformerTests

- (void)testLogToChartEntry {
    SetLog *set = [[SetLogStore instance] create];
    set.weight = N(200);
    set.reps = @3;
    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    [workoutLog.sets addObjectsFromArray:@[set]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [df dateFromString:@"2013-01-12"];
    workoutLog.date = myDate;

    NSDictionary *chartEntry = [[FTOLogGraphTransformer new] logToChartEntry:workoutLog withSet:set];
    NSDictionary *expected = @{
            @"date" : @{
                    @"year" : @2013,
                    @"month" : @1,
                    @"day" : @12
            },
            @"weight" : N(219.8)
    };
    STAssertEqualObjects(chartEntry, expected, @"");
}

- (void)testLogEntriesFromChartAddsObjectIfMissing {
    NSMutableArray *chartData = [@[
            @{@"name" : @"Press", @"data" : @[@{}]}
    ] mutableCopy];
    NSMutableArray *deadLiftData = [[FTOLogGraphTransformer new] logEntriesFromChart:chartData forName:@"Deadlift"];
    STAssertEquals([chartData count], 2U, @"");
    STAssertNotNil(deadLiftData, @"");

    NSMutableArray *pressData = [[FTOLogGraphTransformer new] logEntriesFromChart:chartData forName:@"Press"];
    STAssertEquals([pressData count], 1U, @"");
}

- (void)testGeneratesOneLogPerWorkout {
    SetLog *set1 = [[SetLogStore instance] create];
    set1.name = @"Deadlift";
    set1.weight = N(200);
    set1.reps = @3;

    SetLog *set2 = [[SetLogStore instance] create];
    set1.name = @"Deadlift";
    set1.weight = N(210);
    set1.reps = @2;

    WorkoutLog *workoutLog = [[WorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *myDate = [df dateFromString:@"2013-01-12"];
    workoutLog.date = myDate;
    [workoutLog.sets addObjectsFromArray:@[set1, set2]];

    NSArray *chartData = [[FTOLogGraphTransformer new] buildDataFromLog];
    NSArray *expected = @[@{
            @"name" : @"Deadlift",
            @"data" : @[
                    @{@"weight" : N(223.86), @"date" : @{@"year" : @2013, @"month" : @1, @"day" : @12}}
            ]
    }];
    STAssertEqualObjects(chartData, expected, [NSString stringWithFormat:@"%@", chartData]);
}

@end