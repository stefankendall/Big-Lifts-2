#import "JModel.h"

@class JSetLog;

@protocol JSetLog;

@interface JWorkoutLog : JModel
@property(nonatomic) NSString *name;
@property(nonatomic) NSMutableArray<JSetLog> *sets;
@property(nonatomic) NSDate *date;
@property(nonatomic) BOOL deload;

- (NSArray *)workSets;

- (NSArray *)orderedSets;

- (JSetLog *)bestSet;

- (void)addSet:(JSetLog *)log;
@end