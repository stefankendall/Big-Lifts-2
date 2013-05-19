@class Lift;

@interface Set : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSNumber *weight;
@property(nonatomic) Lift *lift;
@end