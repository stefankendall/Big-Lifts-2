#import "JFTOTriumvirate.h"
#import "JSet.h"
#import "JLift.h"
#import "JWorkout.h"
#import "NSArray+Enumerable.h"

@implementation JFTOTriumvirate

- (int)countMatchingSets:(JSet *)set {
    return [[self matchingSets:set] count];
}

- (NSArray *)matchingSets:(JSet *)set {
    NSArray *matchingSets = [self.workout.orderedSets select:^(JSet *testSet) {
        BOOL matches = set.lift == testSet.lift;
        return matches;
    }];
    return matchingSets;
}

@end