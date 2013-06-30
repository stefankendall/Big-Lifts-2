#import "SetData.h"
#import "Lift.h"
#import "SetStore.h"
#import "Set.h"
#import "FTOSet.h"
#import "FTOSetStore.h"

@implementation SetData

- (id)initWithReps:(int)reps percentage:(NSString *)percentage lift:(Lift *)lift {
    self = [super init];
    if (self) {
        self.reps = reps;
        self.percentage = percentage;
        self.lift = lift;
    }

    return self;
}

+ (id)dataWithReps:(int)reps percentage:(NSString *)percentage lift:(Lift *)lift {
    return [[self alloc] initWithReps:reps percentage:percentage lift:lift];
}

- (id)createSet {
    FTOSet *set = [[FTOSetStore instance] create];
    set.reps = [NSNumber numberWithInt:self.reps];
    set.percentage = [NSDecimalNumber decimalNumberWithString:self.percentage];
    set.lift = self.lift;
    return set;
}

@end