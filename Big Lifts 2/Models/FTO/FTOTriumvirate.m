#import "FTOTriumvirate.h"
#import "Workout.h"
#import "Lift.h"
#import "Set.h"
#import "MRCEnumerable.h"

@implementation FTOTriumvirate

- (int)countMatchingSets:(Set *)set {
    return [[self matchingSets:set] count];
}

- (NSArray *)matchingSets:(Set *)set {
    NSArray *matchingSets = [self.workout.orderedSets select:^(Set *testSet) {
        BOOL matches = set.lift == testSet.lift;
        return matches;
    }];
    return matchingSets;
}

@end