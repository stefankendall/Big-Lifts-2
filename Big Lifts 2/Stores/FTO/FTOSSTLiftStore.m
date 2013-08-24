#import <MRCEnumerable/NSArray+Enumerable.h>
#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"
#import "FTOLiftStore.h"

@implementation FTOSSTLiftStore

- (void)onLoad {
    [[FTOLiftStore instance] registerChangeListener:^{
        [self adjustSstLiftsToMainLifts];
    }];
}

- (void)adjustSstLiftsToMainLifts {
    [self removeMissingLifts];
    [self addNeededLifts];
}

- (void)addNeededLifts {
    [[[FTOLiftStore instance] findAll] each:^(FTOLift *ftoLift) {
        if (![[FTOSSTLiftStore instance] find:@"associatedLift" value:ftoLift]) {
            [self createLift:@"Custom" forLift:ftoLift.name withIncrement:N(5)];
        }
    }];
}

- (void)removeMissingLifts {
    [[[FTOSSTLiftStore instance] findAll] each:^(FTOSSTLift *sstLift) {
        if (![[[FTOLiftStore instance] findAll] containsObject:sstLift.associatedLift]) {
            [[FTOSSTLiftStore instance] remove:sstLift];
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
    FTOSSTLift *lift = [self create];
    lift.name = liftName;
    lift.associatedLift = [[FTOLiftStore instance] find:@"name" value:associatedLiftName];
    lift.increment = increment;
}

@end