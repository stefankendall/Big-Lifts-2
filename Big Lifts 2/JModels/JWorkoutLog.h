#import <JSONModel/JSONModel.h>

@class JSetLog;

@interface JWorkoutLog : JSONModel
@property(nonatomic) NSString *name;
@property(nonatomic) NSMutableOrderedSet *sets;
@property(nonatomic) NSDate *date;
@property(nonatomic) BOOL deload;

- (NSArray *)workSets;

- (NSArray *)orderedSets;

- (JSetLog *)bestSet;

- (void)addSet:(JSetLog *)log;
@end