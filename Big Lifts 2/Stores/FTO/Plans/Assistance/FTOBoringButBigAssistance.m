#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOBoringButBigAssistance.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "Workout.h"
#import "Set.h"
#import "Lift.h"
#import "FTOSetStore.h"
#import "FTOSet.h"
#import "FTOBoringButBig.h"
#import "FTOBoringButBigStore.h"
#import "SetData.h"

@implementation FTOBoringButBigAssistance

- (void)setup {
    [self removeAmrapFromWorkouts];
    [self addBoringSets];
}

- (void)cycleChange {
    FTOBoringButBig *bbb = [[FTOBoringButBigStore instance] first];
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
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        [[[ftoWorkout.workout sets] array] each:^(Set *set) {
            set.amrap = NO;
        }];
    }];
}

- (void)addBoringSets {
    [[[FTOWorkoutStore instance] findAll] each:^(FTOWorkout *ftoWorkout) {
        int sets = ftoWorkout.deload ? 3 : 5;
        Set *set = ftoWorkout.workout.orderedSets[0];
        [ftoWorkout.workout addSets:[self createBoringSets:sets forLift:set.lift]];
    }];
}

- (NSArray *)createBoringSets:(int)numberOfSets forLift:(Lift *)lift {
    NSMutableArray *sets = [@[] mutableCopy];
    NSDecimalNumber *percentage = [[[FTOBoringButBigStore instance] first] percentage];
    for (int set = 0; set < numberOfSets; set++) {
        FTOSet *ftoSet = [[FTOSetStore instance] create];
        ftoSet.lift = lift;
        ftoSet.percentage = percentage;
        ftoSet.reps = @10;
        ftoSet.assistance = YES;
        [sets addObject:ftoSet];
    }
    return sets;
}

@end