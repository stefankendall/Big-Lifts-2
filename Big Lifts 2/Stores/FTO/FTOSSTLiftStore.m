#import "FTOSSTLiftStore.h"
#import "FTOSSTLift.h"
#import "FTOLiftStore.h"

@implementation FTOSSTLiftStore

- (void)setupDefaults {
    [self createLift: @"Front Squat" forLift: @"Deadlift"];
    [self createLift: @"Close Grip Bench" forLift: @"Press"];
    [self createLift: @"Incline Press" forLift: @"Bench"];
    [self createLift: @"Straight Leg Deadlift" forLift: @"Squat"];
}

- (void)createLift:(NSString *)liftName forLift:(NSString *)associatedLiftName {
    FTOSSTLift *lift = [self create];
    lift.name = liftName;
    lift.associatedLift = [[FTOLiftStore instance] find:@"name" value:associatedLiftName];
}

@end