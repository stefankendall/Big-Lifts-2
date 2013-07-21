@class Lift;

@interface SetData : NSObject
@property(nonatomic) int reps;
@property(nonatomic) int maxReps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) Lift *lift;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL optional;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap;

- (id)initWithReps:(int)reps maxReps:(int)maxReps lift:(Lift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup optional:(BOOL)optional percentage:(NSDecimalNumber *)percentage;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift optional:(BOOL)optional;

- (id)initWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift;

- (id)initWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift optional:(BOOL)optional;

+ (id)dataWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift optional:(BOOL)optional;


+ (id)dataWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift optional:(BOOL)optional;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift;

- (id)createSet;

@end