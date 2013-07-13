@interface Lift : NSManagedObject
@property(nonatomic) NSString *name;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) NSNumber *order;
@property(nonatomic) NSDecimalNumber *increment;
@property(nonatomic) BOOL usesBar;
@end