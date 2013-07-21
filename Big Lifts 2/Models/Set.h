@class Lift;

@interface Set : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) Lift *lift;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL optional;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;
@end