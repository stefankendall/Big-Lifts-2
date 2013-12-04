#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOLiftStore.h"
#import "JFTOLift.h"
#import "JSettingsStore.h"
#import "JFTOSSTLiftStore.h"

@implementation JFTOLiftStore

- (Class)modelClass {
    return JFTOLift.class;
}

- (void)setupDefaults {
    self.isSettingDefaults = YES;
    [self createWithName:@"Bench" increment:5 order:0];
    [self createWithName:@"Squat" increment:10 order:1];
    [self createWithName:@"Press" increment:5 order:2];
    [self createWithName:@"Deadlift" increment:10 order:3];
    self.isSettingDefaults = NO;
}

- (void)incrementLifts {
    [[self findAll] each:^(JFTOLift *lift) {
        [lift setWeight:[lift.weight decimalNumberByAdding:lift.increment]];
    }];
}

- (void)createWithName:(NSString *)name increment:(int)increment order:(int)order {
    JFTOLift *lift = [self create];
    lift.name = name;
    lift.increment = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:increment] decimalValue]];
    lift.order = [NSNumber numberWithInt:order];
    lift.usesBar = YES;
}

- (void)adjustForKg {
    JSettingsStore *settingsStore = [JSettingsStore instance];
    NSArray *liftNames = [[self findAll] collect:^id(JLift *lift) {
        return lift.name;
    }];
    [liftNames each:^(NSString *liftName) {
        JFTOLift *lift = [[JFTOLiftStore instance] find:@"name" value:liftName];
        lift.increment = [lift.increment isEqualToNumber:[settingsStore defaultLbsIncrementForLift:lift.name]] ?
                [settingsStore defaultIncrementForLift:lift.name] : lift.increment;
    }];
}

- (void)removeAtIndex:(int)index1 {
    [super removeAtIndex:index1];
    [[JFTOSSTLiftStore instance] adjustSstLiftsToMainLifts];
}

- (void)remove:(id)object {
    [super remove:object];
    [[JFTOSSTLiftStore instance] adjustSstLiftsToMainLifts];
}

- (id)create {
    JFTOLift *lift = [super create];
    if (!self.isSettingDefaults) {
        [[JFTOSSTLiftStore instance] adjustSstLiftsToMainLifts];
    }
    return lift;
}

@end