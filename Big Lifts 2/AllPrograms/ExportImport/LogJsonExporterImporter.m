#import "LogJsonExporterImporter.h"
#import "JSetLogStore.h"
#import "JWorkoutLogStore.h"

@implementation LogJsonExporterImporter

+ (NSString *)export {
    NSArray *setLogsSerialized = [[JSetLogStore instance] serializeAndCache];
    [[JSetLogStore instance] clearSyncCache];

    NSArray *workoutLogsSerialized = [[JWorkoutLogStore instance] serializeAndCache];
    [[JWorkoutLogStore instance] clearSyncCache];

    return [NSString stringWithFormat:@"{"
                                              @"\"setLogs\":[%@],"
                                              @"\"workoutLogs\":[%@]"
                                              "}",
                                      [setLogsSerialized componentsJoinedByString:@","],
                                      [workoutLogsSerialized componentsJoinedByString:@","]
    ];
}

+ (BOOL)importJson:(NSString *)json {
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    if (!dictionary[@"setLogs"]) {
        return NO;
    }

    NSArray *setLogs = dictionary[@"setLogs"];
    NSMutableArray *setLogsAsStrings = [@[] mutableCopy];
    for (NSDictionary *dict in setLogs) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        [setLogsAsStrings addObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    }

    NSArray *workoutLogs = dictionary[@"workoutLogs"];
    NSMutableArray *workoutLogsAsStrings = [@[] mutableCopy];
    for (NSDictionary *dict in workoutLogs) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        [workoutLogsAsStrings addObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    }

    [[JSetLogStore instance] empty];
    [[JSetLogStore instance] setupData:setLogsAsStrings];

    [[JWorkoutLogStore instance] empty];
    [[JWorkoutLogStore instance] setupData:workoutLogsAsStrings];
    return YES;
}

@end