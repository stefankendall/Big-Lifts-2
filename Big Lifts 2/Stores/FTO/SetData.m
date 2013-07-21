#import "SetData.h"
#import "Lift.h"
#import "SetStore.h"
#import "Set.h"
#import "FTOSet.h"
#import "FTOSetStore.h"

@implementation SetData

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup optional:(BOOL)optional {
    self = [super init];
    if (self) {
        self.reps = reps;
        self.percentage = percentage;
        self.lift = lift;
        self.amrap = amrap;
        self.warmup = warmup;
        self.optional = optional;
    }
    return self;
}

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup {
    return [[self alloc] initWithReps:reps percentage:percentage lift:lift amrap:amrap warmup:warmup optional:NO ];
}

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap {
    return [self initWithReps:reps percentage:percentage lift:lift amrap:amrap warmup:NO optional:NO ];
}

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap {
    return [[self alloc] initWithReps:reps percentage:percentage lift:lift amrap:amrap];
}

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift {
    return [self initWithReps:reps percentage:percentage lift:lift amrap:NO];
}

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift {
    return [[self alloc] initWithReps:reps percentage:percentage lift:lift];
}

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift optional:(BOOL)optional {
    return [self initWithReps:reps percentage:percentage lift:lift amrap:NO warmup:NO optional:optional];
}

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift optional:(BOOL)optional {
    return [[self alloc] initWithReps:reps percentage:percentage lift:lift optional:optional];
}

- (id)createSet {
    FTOSet *set = [[FTOSetStore instance] create];
    set.reps = [NSNumber numberWithInt:self.reps];
    set.percentage = self.percentage;
    set.lift = self.lift;
    set.amrap = self.amrap;
    set.warmup = self.warmup;
    set.optional = self.optional;
    return set;
}

@end