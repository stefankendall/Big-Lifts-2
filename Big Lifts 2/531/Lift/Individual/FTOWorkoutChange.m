#import "FTOWorkoutChange.h"
#import "JFTOWorkout.h"
#import "SetChange.h"

@implementation FTOWorkoutChange

- (instancetype)initWithWorkout:(JFTOWorkout *)workout {
    self = [super init];
    if (self) {
        self.workout = workout;
        self.changesBySet = [@{} mutableCopy];
    }

    return self;
}

@end