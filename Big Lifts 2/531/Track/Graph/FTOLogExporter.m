#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOLogExporter.h"
#import "WorkoutLog.h"
#import "WorkoutLogStore.h"
#import "SetLog.h"
#import "OneRepEstimator.h"

@implementation FTOLogExporter

- (NSString *)csv {
    NSMutableString *csv = [@"name,date,weight,reps,estimated max\n" mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [[[WorkoutLogStore instance] findAllWhere:@"name" value:@"5/3/1"] each:^(WorkoutLog *log) {
        SetLog *bestSet = [log bestSet];
        [csv appendString:bestSet.name];
        [csv appendString:@","];
        [csv appendString:[dateFormatter stringFromDate:log.date]];
        [csv appendString:@","];
        [csv appendString:[bestSet.weight stringValue]];
        [csv appendString:@","];
        [csv appendString:[bestSet.reps stringValue]];
        [csv appendString:@","];
        NSDecimalNumber *oneRep = [[OneRepEstimator new] estimate:bestSet.weight withReps:[bestSet.reps intValue]];
        [csv appendString:[oneRep stringValue]];
        [csv appendString:@"\n"];
    }];
    return csv;
}


@end