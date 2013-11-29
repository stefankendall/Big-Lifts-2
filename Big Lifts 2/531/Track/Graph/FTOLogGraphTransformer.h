@class JSetLog;
@class JWorkoutLog;

@interface FTOLogGraphTransformer : NSObject
- (NSArray *)buildDataFromLog;

- (NSMutableArray *)logEntriesFromChart:(NSMutableArray *)chartData forName:(NSString *)name;

- (NSDictionary *)logToChartEntry:(JWorkoutLog *)log withSet:(JSetLog *)set;
@end