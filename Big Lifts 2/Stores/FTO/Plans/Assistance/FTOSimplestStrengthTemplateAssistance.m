#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOSimplestStrengthTemplateAssistance.h"
#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "FTOWorkout.h"
#import "FTOWorkoutStore.h"
#import "Workout.h"
#import "Set.h"
#import "SetStore.h"
#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"

@implementation FTOSimplestStrengthTemplateAssistance

- (void)setup {
    for (int week = 1; week <= 4; week++) {
        [[[FTOLiftStore instance] findAll] each:^(FTOLift *lift) {
            [self createAssistanceFor:lift withWeek:week];
        }];
    }
}

- (void)createAssistanceFor:(FTOLift *)lift withWeek:(int)week {
    NSDictionary *weeksToData = @{
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
    };

    NSArray *weekData = weeksToData[[NSNumber numberWithInt: week]];
    FTOWorkout *ftoWorkout = [[[FTOWorkoutStore instance] findAll] detect:^BOOL(FTOWorkout *workout) {
        return [workout.week intValue] == week && [workout.workout.sets[0] lift] == lift;
    }];

    FTOSSTLift *sstLift = [[FTOSSTLiftStore instance] find:@"associatedLift" value: lift];
    [weekData each:^(NSDictionary *data) {
        Set *set = [[SetStore instance] create];
        set.reps = data[@"reps"];
        set.percentage = data[@"percentage"];
        set.lift = sstLift;
        [ftoWorkout.workout.sets addObject:set];
    }];
}

- (void)cycleChange {
    [[[FTOSSTLiftStore instance] findAll] each:^(FTOSSTLift *lift) {
        lift.weight = [lift.weight decimalNumberByAdding:lift.increment];
    }];
}
@end