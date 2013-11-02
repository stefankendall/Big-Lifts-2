#import <MRCEnumerable/NSArray+Utilities.h>
#import <MRCEnumerable/NSSet+Utilities.h>
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

    if ([self orderingBroken]) {
        [self fixOrdering];
    }

    [self dataWasSynced];
}

- (void)fixOrdering {
    int order = 0;
    for (FTOLift *lift in [self findAll]) {
        [lift setOrder:[NSNumber numberWithInt:order++]];
    }
}

- (BOOL)orderingBroken {
    NSOrderedSet *orders = [self unique:@"order"];
    return [orders count] != [self count] || [orders containsObject:[NSNull null]];
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
    [self removeDoubledLifts];
}

- (void)removeDoubledLifts {
    NSMutableSet *doubledLiftNames = [NSMutableSet new];
    for (FTOLift *lift in [self findAll]) {
        if ([[self findAllWhere:@"name" value:lift.name] count] > 1) {
            [doubledLiftNames addObject:lift.name];
        }
    }
    if (![doubledLiftNames empty]) {
        for (NSString *liftName in doubledLiftNames) {
            NSArray *lifts = [self findAllWhere:@"name" value:liftName];
            FTOLift *lift1 = lifts[0];
            FTOLift *lift2 = lifts[1];
            FTOLift *liftToRemove = nil;
            if ([lift1.weight compare:lift2.weight] == NSOrderedDescending) {
                liftToRemove = lift2;
            }
            else {
                liftToRemove = lift1;
            }
            [self remove:liftToRemove];
        }
        [[FTOWorkoutStore instance] restoreTemplate];
    }
}

- (void)removeUnusedLifts {
    NSMutableSet *usedLifts = [NSMutableSet new];
    for (FTOWorkout *ftoWorkout in [[FTOWorkoutStore instance] findAll]) {
        [usedLifts addObject:[ftoWorkout.workout firstLift]];
    }
    NSMutableArray *unusedLifts = [@[] mutableCopy];
    for (FTOLift *lift in [self findAll]) {
        if (![usedLifts containsObject:lift]) {
            [unusedLifts addObject:lift];
        }
    }

    if (![unusedLifts empty]) {
        for (FTOLift *unusedLift in unusedLifts) {
            [self remove:unusedLift];
        }
        [[FTOWorkoutStore instance] restoreTemplate];
    }
}


@end