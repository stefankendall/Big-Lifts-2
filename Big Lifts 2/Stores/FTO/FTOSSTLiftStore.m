#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"
#import "FTOLiftStore.h"

@implementation FTOSSTLiftStore

- (void)setupDefaults {
    [self createLift: @"Front Squat" forLift: @"Deadlift" withIncrement: N(10)];
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