@class SetLog;
@class WorkoutLog;

@interface FTOLogGraphTransformer : NSObject
- (NSArray *)buildDataFromLog;

- (NSMutableArray *)logEntriesFromChart:(NSMutableArray *)chartData forName:(NSString *)name;

- (SetLog *)bestSetFromWorkout:(WorkoutLog *)log1;

- (NSDictionary *)logToChartEntry:(WorkoutLog *)log withSet:(SetLog *)set;
@end