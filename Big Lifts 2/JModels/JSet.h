#import "JModel.h"

@class JLift;

@interface JSet : JModel
@property(nonatomic) NSNumber<Optional> *reps;
@property(nonatomic) NSNumber<Optional> *maxReps;
@property(nonatomic) NSDecimalNumber<Optional> *percentage;
@property(nonatomic) JLift<Optional> *lift;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL optional;
@property(nonatomic) BOOL assistance;

- (NSDecimalNumber *) effectiveWeight;

- (NSDecimalNumber *)roundedEffectiveWeight;

@end