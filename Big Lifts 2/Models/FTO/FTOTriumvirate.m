#import "FTOTriumvirate.h"
#import "Workout.h"
#import "Lift.h"
#import "Set.h"
#import "MRCEnumerable.h"

@implementation FTOTriumvirate

- (int)countMatchingSets:(Set *)set {
    NSArray *matchingSets = [[self.workout.sets array] select:^(Set *testSet) {
        BOOL matches = set.lift == testSet.lift;
        return matches;
    }];
    return [matchingSets count];
}

@end