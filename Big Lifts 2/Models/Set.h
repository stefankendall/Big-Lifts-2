@class Lift;

@interface Set : NSManagedObject
@property(nonatomic) NSDecimalNumber *reps;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) Lift *lift;
@end