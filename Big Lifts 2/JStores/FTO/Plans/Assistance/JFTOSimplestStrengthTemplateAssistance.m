#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOSimplestStrengthTemplateAssistance.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "JFTOWorkoutStore.h"
#import "JFTOWorkout.h"
#import "JWorkout.h"
#import "JFTOSSTLift.h"
#import "JFTOSSTLiftStore.h"
#import "JSet.h"
#import "JFTOSettings.h"
#import "JFTOSettingsStore.h"
#import "JFTOVariantStore.h"
#import "JFTOVariant.h"
#import "JFTOSetStore.h"
#import "JFTOSet.h"

@implementation JFTOSimplestStrengthTemplateAssistance

- (void)setup {
    NSArray *weeks = [[[JFTOWorkoutStore instance] unique:@"week"] array];
    for (NSNumber *week in weeks) {
        [[[JFTOLiftStore instance] findAll] each:^(JFTOLift *lift) {
            [self createAssistanceFor:lift withWeek:[week intValue]];
        }];
    }
}

- (void)createAssistanceFor:(JFTOLift *)lift withWeek:(int)week {
    NSDictionary *weeksToData = [self getWeeksData];
    NSArray *weekData = weeksToData[[NSNumber numberWithInt:week]];
    JFTOWorkout *ftoWorkout = [self findWorkoutWithLift:lift week:week];
    JFTOSSTLift *sstLift = [[JFTOSSTLiftStore instance] find:@"associatedLift" value:lift];
    [weekData each:^(NSDictionary *data) {
        JFTOSet *set = [[JFTOSetStore instance] create];
        set.reps = data[@"reps"];
        set.percentage = data[@"percentage"];
        set.lift = sstLift;
        set.assistance = YES;
        [ftoWorkout.workout addSet:set];
    }];
}

- (NSDictionary *)getWeeksData {
    NSMutableDictionary *weeksToData = [@{
            @1 : @[
                    @{@"percentage" : N(50), @"reps" : @10},
                    @{@"percentage" : N(60), @"reps" : @10},
                    @{@"percentage" : N(70), @"reps" : @10}
            ],
            @2 : @[
                    @{@"percentage" : N(60), @"reps" : @8},
                    @{@"percentage" : N(70), @"reps" : @8},
                    @{@"percentage" : N(80), @"reps" : @6}
            ],
            @3 : @[
                    @{@"percentage" : N(65), @"reps" : @5},
                    @{@"percentage" : N(75), @"reps" : @5},
                    @{@"percentage" : N(85), @"reps" : @5}
            ],
            @4 : @[
                    @{@"percentage" : N(40), @"reps" : @5},
                    @{@"percentage" : N(50), @"reps" : @5},
                    @{@"percentage" : N(60), @"reps" : @5}
            ]
    } mutableCopy];

    if ([[[[JFTOVariantStore instance] first] name] isEqual:FTO_VARIANT_POWERLIFTING]) {
        NSArray *week1 = weeksToData[@1];
        weeksToData[@1] = weeksToData[@2];
        weeksToData[@2] = week1;
    }

    if ([[[JFTOSettingsStore instance] first] sixWeekEnabled]) {
        NSArray *deload = weeksToData[@4];
        for (int week = 1; week <= 3; week++) {
            weeksToData[[NSNumber numberWithInt:(week + 3)]] = weeksToData[[NSNumber numberWithInt:week]];
        }
        weeksToData[@7] = deload;
    }

    return weeksToData;
}

- (JFTOWorkout *)findWorkoutWithLift:(JFTOLift *)lift week:(int)week {
    return [[[JFTOWorkoutStore instance] findAll] detect:^BOOL(JFTOWorkout *workout) {
        if ([workout.workout.sets count] == 0) {
            return false;
        }
        return [workout.week intValue] == week && [workout.workout.sets[0] lift] == lift;
    }];
}

- (void)cycleChange {
    [[[JFTOSSTLiftStore instance] findAll] each:^(JFTOSSTLift *lift) {
        lift.weight = [lift.weight decimalNumberByAdding:lift.increment];
    }];
}
@end