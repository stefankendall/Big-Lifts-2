#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOBoringButBigAssistance.h"
#import "JFTOBoringButBig.h"
#import "JFTOBoringButBigStore.h"
#import "JFTOWorkout.h"
#import "JFTOWorkoutStore.h"
#import "JFTOLift.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JFTOSet.h"
#import "BoringButBigHelper.h"
#import "FTOLiftWorkoutViewController.h"

@implementation JFTOBoringButBigAssistance

- (void)setup {
    [self addBoringSets];
}

- (void)cycleChange {
    JFTOBoringButBig *bbb = [[JFTOBoringButBigStore instance] first];
    if ([bbb threeMonthChallenge]) {
        NSArray *percentages = @[N(50), N(60), N(70)];
        NSUInteger index = [percentages indexOfObject:bbb.percentage];
        if (index != NSNotFound) {
            [bbb setPercentage:percentages[((index + 1) % percentages.count)]];
        }
    }

    [self removeExistingAssistance];
    [self setup];
}

- (void)removeExistingAssistance {
    [[[JFTOWorkoutStore instance] findAll] each:^(JFTOWorkout *ftoWorkout) {
        for(JSet *set in ftoWorkout.workout.assistanceSets){
            [ftoWorkout.workout.sets removeObject:set];
        }
    }];
}

- (void)addBoringSets {
    for (JFTOWorkout *ftoWorkout in [[JFTOWorkoutStore instance] findAll]) {
        if ([ftoWorkout.workout.sets count] == 0) {
            continue;
        }

        JFTOSet *set = ftoWorkout.workout.sets[0];
        [BoringButBigHelper addSetsToWorkout:ftoWorkout.workout withLift:set.lift deload:ftoWorkout.deload];
    };
}

@end