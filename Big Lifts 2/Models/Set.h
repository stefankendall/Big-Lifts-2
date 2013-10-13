@class Lift;
@class Workout;

@interface Set : NSManagedObject
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSNumber *maxReps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) Lift *lift;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL optional;
@property(nonatomic) BOOL assistance;
@property(nonatomic) Workout *workout;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;

- (BOOL)hasVariableReps;
@end