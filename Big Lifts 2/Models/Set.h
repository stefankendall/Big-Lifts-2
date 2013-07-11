@class Lift;

@interface Set : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) NSDecimalNumber *weight;
@property(nonatomic) Lift *lift;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL amrap;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;
@end