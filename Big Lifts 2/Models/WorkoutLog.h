@class SetLog;

@interface WorkoutLog : NSManagedObject {
}

@property(nonatomic) NSString *name;
@property(nonatomic) NSMutableOrderedSet *sets;
@property(nonatomic) NSDate *date;

- (NSArray *)workSets;

- (NSArray *)orderedSets;

- (SetLog *)bestSet;

- (void)addSet:(SetLog *)log;
@end