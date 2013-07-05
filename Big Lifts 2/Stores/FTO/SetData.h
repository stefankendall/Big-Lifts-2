@class Lift;

@interface SetData : NSObject
@property(nonatomic) int reps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) Lift *lift;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift;

- (id)createSet;

@end