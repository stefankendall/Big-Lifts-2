@interface SSWorkout : NSManagedObject
@property(nonatomic) NSString *name;
@property(nonatomic) NSNumber *order;
@property(nonatomic) NSMutableOrderedSet *workouts;
@property(nonatomic) NSNumber *alternation;
@end