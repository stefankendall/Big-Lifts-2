#import "JSONModel/JSONModel.h"

@class JLift;

@interface JSet : JSONModel
@property(nonatomic) NSNumber *reps;
@property(nonatomic) NSNumber<Optional> *maxReps;
@property(nonatomic) NSNumber<Optional> *order;
@property(nonatomic) NSDecimalNumber<Optional> *percentage;
@property(nonatomic) JLift *lift;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL optional;
@property(nonatomic) BOOL assistance;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;

- (BOOL)hasVariableReps;
@end