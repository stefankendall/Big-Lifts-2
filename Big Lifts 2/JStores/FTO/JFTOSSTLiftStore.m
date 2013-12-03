#import <MRCEnumerable/NSArray+Enumerable.h>
#import "JFTOSSTLiftStore.h"
#import "JFTOSSTLift.h"
#import "JFTOLiftStore.h"
#import "JFTOLift.h"

@implementation JFTOSSTLiftStore

- (Class)modelClass {
    return JFTOSSTLift.class;
}

- (void)adjustSstLiftsToMainLifts {
    [self removeMissingLifts];
    [self addNeededLifts];
}

- (void)addNeededLifts {
    [[[JFTOLiftStore instance] findAll] each:^(JFTOLift *ftoLift) {
        if (![[JFTOSSTLiftStore instance] find:@"associatedLift" value:ftoLift]) {
            [self createLift:@"Custom" forLift:ftoLift.name withIncrement:N(5)];
        }
    }];
}

- (void)removeMissingLifts {
    [[[JFTOSSTLiftStore instance] findAll] each:^(JFTOSSTLift *sstLift) {
        if (![[[JFTOLiftStore instance] findAll] containsObject:sstLift.associatedLift]) {
            [[JFTOSSTLiftStore instance] remove:sstLift];
        }
    }];
}

- (void)setupDefaults {
    [self createLift:@"Front Squat" forLift:@"Deadlift" withIncrement:N(10)];
    [self createLift:@"Close Grip Bench" forLift:@"Press" withIncrement:N(5)];
    [self createLift:@"Incline Press" forLift:@"Bench" withIncrement:N(5)];
    [self createLift:@"Straight Leg Deadlift" forLift:@"Squat" withIncrement:N(10)];
}

- (void)createLift:(NSString *)liftName forLift:(NSString *)associatedLiftName withIncrement:(NSDecimalNumber *)increment {
    JFTOSSTLift *lift = [self create];
    lift.name = liftName;
    lift.associatedLift = [[JFTOLiftStore instance] find:@"name" value:associatedLiftName];
    lift.increment = increment;
}

@end