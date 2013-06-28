@class Lift;

@interface SetData : NSObject
@property(nonatomic) int reps;
@property(nonatomic) NSString *percentage;
@property(nonatomic) Lift *lift;

- (id)initWithReps:(int)reps percentage:(NSString *)percentage lift:(Lift *)lift;

+ (id)dataWithReps:(int)reps percentage:(NSString *)percentage lift:(Lift *)lift;

- (id)createSet;

@end