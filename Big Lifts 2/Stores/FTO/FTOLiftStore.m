#import "FTOLiftStore.h"
#import "FTOLift.h"
#import "NSArray+Enumerable.h"
#import "Settings.h"
#import "SettingsStore.h"
#import "FTOWorkoutStore.h"
#import "FTOWorkout.h"
#import "Workout.h"

@implementation FTOLiftStore

- (void)setupDefaults {
    [self createWithName:@"Bench" increment:5 order:0];
    [self createWithName:@"Squat" increment:10 order:1];
    [self createWithName:@"Press" increment:5 order:2];
    [self createWithName:@"Deadlift" increment:10 order:3];
}

- (void)onLoad {
    [[SettingsStore instance] registerChangeListener:^{
        [self adjustForKg];
    }];
}

- (void)incrementLifts {
    [[self findAll] each:^(FTOLift *lift) {
        [lift setWeight:[lift.weight decimalNumberByAdding:lift.increment]];
    }];
}

- (void)createWithName:(NSString *)name increment:(int)increment order:(int)order {
    FTOLift *lift = [self create];
    lift.name = name;
    lift.increment = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:increment] decimalValue]];
    lift.order = [NSNumber numberWithInt:order];
    lift.usesBar = YES;
}

- (void)adjustForKg {
    SettingsStore *settingsStore = [SettingsStore instance];
    Settings *settings = [settingsStore first];
    if ([settings.units isEqualToString:@"kg"]) {
        NSArray *liftNames = [[self findAll] collect:^id(Lift *lift) {
            return lift.name;
        }];
        [liftNames each:^(NSString *liftName) {
            FTOLift *lift = [[FTOLiftStore instance] find:@"name" value:liftName];
            lift.increment = [settingsStore defaultLbsIncrementForLift:lift.name] ?
                    [settingsStore defaultIncrementForLift:lift.name] : lift.increment;
        }];
    }
}

- (void)dataWasSynced {
    [self removeUnusedLifts];
}

- (void)removeUnusedLifts {
    NSMutableSet *usedLifts = [NSMutableSet new];
    for (FTOWorkout *ftoWorkout in [[FTOWorkoutStore instance] findAll]) {
        [usedLifts addObject:[ftoWorkout.workout firstLift]];
    }
    NSMutableArray *unusedLifts = [@[] mutableCopy];
    for (FTOLift *lift in [self findAll]) {
        if(![usedLifts containsObject:lift]){
            [unusedLifts addObject:lift];
        }
    }

    for( FTOLift *unusedLift in unusedLifts){
        [self remove:unusedLift];
    }
}


@end