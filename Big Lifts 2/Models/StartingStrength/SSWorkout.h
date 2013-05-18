@interface SSWorkout : NSManagedObject
@property(nonatomic) NSString *name;
@property(nonatomic) NSMutableOrderedSet *lifts;
@property(nonatomic) NSNumber *order;
@end