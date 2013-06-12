@interface WorkoutLog : NSManagedObject

@property(nonatomic) NSMutableOrderedSet *sets;
@property(nonatomic) NSDate *date;
@end