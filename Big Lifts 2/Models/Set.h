@class Lift;

@interface Set : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) Lift *lift;
@property(nonatomic) BOOL warmup;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;
@end