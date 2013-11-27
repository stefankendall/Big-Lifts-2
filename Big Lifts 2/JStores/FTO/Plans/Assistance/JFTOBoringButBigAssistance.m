#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOBoringButBigAssistance.h"
#import "JFTOBoringButBig.h"
#import "JFTOBoringButBigStore.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JFTOSetStore.h"
#import "JFTOSet.h"

@implementation JFTOBoringButBigAssistance

- (void)setup {
    [self removeAmrapFromWorkouts];
    [self addBoringSets];
}

- (void)cycleChange {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    if ([bbb threeMonthChallenge]) {
        NSArray *percentages = @[N(50), N(60), N(70)];
        int index = [percentages indexOfObject:bbb.percentage];
        if (index != NSNotFound) {
            [bbb setPercentage:percentages[(NSUInteger) ((index + 1) % percentages.count)]];
        }
    }

    [self setup];
}

- (void)removeAmrapFromWorkouts {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        [ftoWorkout.workout.orderedSets each:^(JSet *set) {
            set.amrap = NO;
        }];
    }];
}

- (void)addBoringSets {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        int sets = ftoWorkout.deload ? 3 : 5;
        JSet *set = ftoWorkout.workout.orderedSets[0];
        [ftoWorkout.workout addSets:[self createBoringSets:sets forLift:set.lift]];
    }];
}

- (NSArray *)createBoringSets:(int)numberOfSets forLift:(JLift *)lift {
    NSMutableArray *sets = [@[] mutableCopy];
    NSDecimalNumber *percentage = [[[JFTOBoringButBigStore instance] first] percentage];
    for (int set = 0; set < numberOfSets; set++) {
        JFTOSet *ftoSet = [[JFTOSetStore instance] create];
        ftoSet.lift = lift;
        ftoSet.percentage = percentage;
        ftoSet.reps = @10;
        ftoSet.assistance = YES;
        [sets addObject:ftoSet];
    }
    return sets;
}

@end