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
#import "JSetStore.h"

@implementation JFTOSimplestStrengthTemplateAssistance

- (void)setup {
    for (int week = 1; week <= 4; week++) {
        [[[JFTOLiftStore instance] findAll] each:^(JFTOLift *lift) {
            [self createAssistanceFor:lift withWeek:week];
        }];
    }
}

- (void)createAssistanceFor:(JFTOLift *)lift withWeek:(int)week {
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

    NSArray *weekData = weeksToData[[NSNumber numberWithInt:week]];
    JFTOWorkout *ftoWorkout = [[[JFTOWorkoutStore instance] findAll] detect:^BOOL(JFTOWorkout *workout) {
        if([workout.workout.orderedSets count] == 0){
            return false;
        }
        return [workout.week intValue] == week && [workout.workout.orderedSets[0] lift] == lift;
    }];

    JFTOSSTLift *sstLift = [[JFTOSSTLiftStore instance] find:@"associatedLift" value:lift];
    [weekData each:^(NSDictionary *data) {
        JSet *set = [[JSetStore instance] create];
        set.reps = data[@"reps"];
        set.percentage = data[@"percentage"];
        set.lift = sstLift;
        set.assistance = YES;
        [ftoWorkout.workout addSet:set];
    }];
}

- (void)cycleChange {
    [[[JFTOSSTLiftStore instance] findAll] each:^(JFTOSSTLift *lift) {
        lift.weight = [lift.weight decimalNumberByAdding:lift.increment];
    }];
}
@end