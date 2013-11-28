#import "JSJWorkoutStore.h"
#import "JSJWorkout.h"
#import "JSetStore.h"
#import "JSJLiftStore.h"
#import "JSJLift.h"
#import "JWorkoutStore.h"
#import "JSet.h"
#import "JWorkout.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JSJWorkoutStore

- (Class)modelClass {
    return JSJWorkout.class;
}

- (void)setupDefaults {
    [self createWorkoutInWeek:1 order:1 sets:6 reps:6 percentage:N(70) minWeightAdd:0 maxWeightAdd:0];
    [self createWorkoutInWeek:1 order:2 sets:7 reps:5 percentage:N(75) minWeightAdd:0 maxWeightAdd:0];
    [self createWorkoutInWeek:1 order:3 sets:8 reps:4 percentage:N(80) minWeightAdd:0 maxWeightAdd:0];
    [self createWorkoutInWeek:1 order:4 sets:10 reps:3 percentage:N(85) minWeightAdd:0 maxWeightAdd:0];

    [self createWorkoutInWeek:2 order:5 sets:6 reps:6 percentage:N(70) minWeightAdd:10 maxWeightAdd:20];
    [self createWorkoutInWeek:2 order:6 sets:7 reps:5 percentage:N(75) minWeightAdd:10 maxWeightAdd:20];
    [self createWorkoutInWeek:2 order:7 sets:8 reps:4 percentage:N(80) minWeightAdd:10 maxWeightAdd:20];
    [self createWorkoutInWeek:2 order:8 sets:10 reps:3 percentage:N(85) minWeightAdd:10 maxWeightAdd:20];

    [self createWorkoutInWeek:3 order:9 sets:6 reps:6 percentage:N(70) minWeightAdd:15 maxWeightAdd:25];
    [self createWorkoutInWeek:3 order:10 sets:7 reps:5 percentage:N(75) minWeightAdd:15 maxWeightAdd:25];
    [self createWorkoutInWeek:3 order:11 sets:8 reps:4 percentage:N(80) minWeightAdd:15 maxWeightAdd:25];
    [self createWorkoutInWeek:3 order:12 sets:10 reps:3 percentage:N(85) minWeightAdd:15 maxWeightAdd:25];
}

- (void)createWorkoutInWeek:(int)week order:(int)order sets:(int)sets reps:(int)reps percentage:(NSDecimalNumber *)percentage minWeightAdd:(int)minWeightAdd maxWeightAdd:(int)maxWeightAdd {
    JSJWorkout *sjWorkout = [[JSJWorkoutStore instance] create];
    sjWorkout.done = NO;
    sjWorkout.week = [NSNumber numberWithInt:week];
    sjWorkout.order = [NSNumber numberWithInt:order];
    sjWorkout.minWeightAdd = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:minWeightAdd] decimalValue]];
    sjWorkout.maxWeightAdd = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:maxWeightAdd] decimalValue]];
    JWorkout *workout = [[JWorkoutStore instance] create];

    JSJLift *lift = [[JSJLiftStore instance] first];
    for (int setCount = 0; setCount < sets; setCount++) {
        JSet *set = [[JSetStore instance] create];
        set.lift = lift;
        set.percentage = percentage;
        set.reps = [NSNumber numberWithInt:reps];
        [workout addSet:set];
    }

    sjWorkout.workout = workout;
}

- (void)adjustForKg {
    JSettings *settings = [[JSettingsStore instance] first];
    NSString *units = [settings units];
    NSArray *week2Workouts = [self findAllWhere:@"week" value:@2];
    NSArray *week3Workouts = [self findAllWhere:@"week" value:@3];
    for (JSJWorkout *workout in week2Workouts) {
        if ([workout.minWeightAdd isEqualToNumber:N(10)] && [units isEqualToString:@"kg"]){
            workout.minWeightAdd = N(5);
            workout.maxWeightAdd = N(10);
        }
        else if ([workout.minWeightAdd isEqualToNumber:N(5)] && [units isEqualToString:@"lbs"]){
            workout.minWeightAdd = N(10);
            workout.maxWeightAdd = N(20);
        }
    }

    for (JSJWorkout *workout in week3Workouts) {
        if ([workout.minWeightAdd isEqualToNumber:N(15)] && [units isEqualToString:@"kg"]){
            workout.minWeightAdd = N(7);
            workout.maxWeightAdd = N(12);
        }
        else if ([workout.minWeightAdd isEqualToNumber:N(7)] && [units isEqualToString:@"lbs"]){
            workout.minWeightAdd = N(15);
            workout.maxWeightAdd = N(25);
        }
    }
}


@end