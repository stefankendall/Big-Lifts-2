#import "JModel.h"

@class JSetLog;

@protocol JSetLog;

@interface JWorkoutLog : JModel
@property(nonatomic) NSString<Optional> *name;
@property(nonatomic) NSMutableArray<JSetLog, Optional> *sets;
@property(nonatomic) NSDate<Optional> *date;
@property(nonatomic) BOOL deload;

- (NSArray *)workSets;

- (NSArray *)orderedSets;

- (JSetLog *)bestSet;

- (void)addSet:(JSetLog *)log;
@end