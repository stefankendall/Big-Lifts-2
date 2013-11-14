@class SetLog;

@interface WorkoutLog : NSManagedObject {
}

@property(nonatomic) NSString *name;
@property(nonatomic) NSMutableOrderedSet *sets;
@property(nonatomic) NSDate *date;
@property(nonatomic) BOOL deload;

- (NSArray *)workSets;

- (NSArray *)orderedSets;

- (SetLog *)bestSet;

- (void)addSet:(SetLog *)log;
@end