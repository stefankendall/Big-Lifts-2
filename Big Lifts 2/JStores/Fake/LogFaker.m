#import "LogFaker.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "JSetLogStore.h"

@implementation LogFaker

+ (void)generateEmptyLogData {
    JSetLog *set1 = [[JSetLogStore instance] create];
    set1.name = nil;
    set1.weight = N(200);
    set1.reps = @1;

    JWorkoutLog *workoutLog = [[JWorkoutLogStore instance] create];
    workoutLog.name = @"5/3/1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    workoutLog.date = [df dateFromString:@"2014-01-12"];

    [workoutLog addSet:set1];
}

+ (void)generateLog {
    for (int i = 0; i < 30; i++) {
        NSDate *date = [[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * i * 3];
        NSLog(@"%@", date);
        JWorkoutLog *log = [[JWorkoutLogStore instance] createWithName:@"5/3/1" date:date];
        NSDecimal decimal = [[NSNumber numberWithInt:i] decimalValue];
        NSDecimalNumber *weight = [N(200) decimalNumberByAdding:[N(10) decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithDecimal:decimal]]];
        JSetLog *setLog = [[JSetLogStore instance] createWithName:@"Bench"
                                                           weight:weight
                                                             reps:1
                                                           warmup:NO
                                                       assistance:NO
                                                            amrap:NO];
        [log addSet:setLog];
    }
}

@end