#import "JSONModel/JSONModel.h"

@class Workout;
@class Lift;
@class JLift;

@interface JSet : JSONModel
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSNumber *maxReps;
@property(nonatomic) NSNumber *order;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) JLift *lift;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL optional;
@property(nonatomic) BOOL assistance;
@property(nonatomic) Workout *workout;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;

- (BOOL)hasVariableReps;
@end