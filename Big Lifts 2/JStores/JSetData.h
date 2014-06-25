@class JLift;

@interface JSetData : NSObject
@property(nonatomic) int reps;
@property(nonatomic) int maxReps;
@property(nonatomic) NSDecimalNumber *percentage;
@property(nonatomic) JLift *lift;
@property(nonatomic) BOOL amrap;
@property(nonatomic) BOOL warmup;
@property(nonatomic) BOOL optional;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift amrap:(BOOL)amrap;

- (id)initWithReps:(int)reps maxReps:(int)maxReps lift:(JLift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup optional:(BOOL)optional percentage:(NSDecimalNumber *)percentage;

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift optional:(BOOL)optional;

- (id)initWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift;

- (id)initWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift optional:(BOOL)optional;

+ (id)dataWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift optional:(BOOL)optional;


+ (id)dataWithReps:(int)reps maxReps:(int)maxReps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift optional:(BOOL)optional;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup optional:(BOOL)optional;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift amrap:(BOOL)amrap;

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(JLift *)lift;

- (id)createSet;

@end