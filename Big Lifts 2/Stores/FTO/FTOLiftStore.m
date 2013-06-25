#import "FTOLiftStore.h"
#import "FTOLift.h"

@implementation FTOLiftStore

- (void)setupDefaults {
    [self createWithName: @"Press" increment: 0 order: 0];
    [self createWithName: @"Deadlift" increment: 0 order: 1];
    [self createWithName: @"Bench" increment: 0 order: 2];
    [self createWithName: @"Squat" increment: 0 order: 3];
}

- (void)createWithName:(NSString *)name increment:(int)increment order:(int)order {
    FTOLift *lift = [self create];
    lift.name = name;
    lift.increment = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:increment] decimalValue]];
    lift.order = [NSNumber numberWithInt:order];
}


@end