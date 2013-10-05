@interface SetLog : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) NSString *name;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL assistance;
@property(nonatomic) BOOL amrap;
@end