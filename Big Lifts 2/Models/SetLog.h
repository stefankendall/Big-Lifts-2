@interface SetLog : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) NSString *name;
@property(nonatomic) BOOL warmup;
@end