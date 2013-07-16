#import "SetData.h"
#import "Lift.h"
#import "SetStore.h"
#import "Set.h"
#import "FTOSet.h"
#import "FTOSetStore.h"

@implementation SetData

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup {
    self = [super init];
    if (self) {
        self.reps = reps;
        self.percentage = percentage;
        self.lift = lift;
        self.amrap = amrap;
        self.warmup = warmup;
    }

    return self;
}

+ (id)dataWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap warmup:(BOOL)warmup {
    return [[self alloc] initWithReps:reps percentage:percentage lift:lift amrap:amrap warmup:warmup];
}

- (id)initWithReps:(int)reps percentage:(NSDecimalNumber *)percentage lift:(Lift *)lift amrap:(BOOL)amrap {
    return [self initWithReps:reps percentage:percentage lift:lift amrap:amrap warmup:NO];
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

- (id)createSet {
    FTOSet *set = [[FTOSetStore instance] create];
    set.reps = [NSNumber numberWithInt:self.reps];
    set.percentage = self.percentage;
    set.lift = self.lift;
    set.amrap = self.amrap;
    set.warmup = self.warmup;
    return set;
}

@end