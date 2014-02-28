#import "LogFaker.h"
#import "JWorkoutLogStore.h"
#import "JWorkoutLog.h"
#import "JSetLog.h"
#import "JSetLogStore.h"

@implementation LogFaker

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