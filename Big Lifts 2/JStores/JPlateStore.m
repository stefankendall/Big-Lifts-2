#import "JPlateStore.h"
#import "JPlate.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation JPlateStore

- (Class)modelClass {
    return JPlate.class;
}

- (void)setupDefaults {
    [self createPlateWithWeight:N(45.0) count:6];
    [self createPlateWithWeight:N(35.0) count:6];
    [self createPlateWithWeight:N(25.0) count:6];
    [self createPlateWithWeight:N(10.0) count:6];
    [self createPlateWithWeight:N(5.0) count:6];
    [self createPlateWithWeight:N(2.5) count:6];
}

- (void)createPlateWithWeight:(NSDecimalNumber *)weight count:(int)count {
    JPlate *p = [self create];
    p.weight = weight;
    p.count = [NSNumber numberWithInt:count];
}

- (NSArray *)findAll {
    NSLog(@"Plates123");
    NSLog(@"%@", self.data);

    NSArray *sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO]];
    NSArray *dataSortedByWeight = [self.data sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@", dataSortedByWeight);
    return dataSortedByWeight;
}

- (void)adjustForKg {
    JSettings *settings = [[JSettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"]) {
        JPlate *firstPlate = [self first];
        if ([firstPlate.weight isEqualToNumber:N(45.0)]) {
            [self empty];
            [self createPlateWithWeight:N(20.0) count:6];
            [self createPlateWithWeight:N(15.0) count:6];
            [self createPlateWithWeight:N(10.0) count:6];
            [self createPlateWithWeight:N(5.0) count:6];
            [self createPlateWithWeight:N(2.5) count:6];
            [self createPlateWithWeight:N(1) count:6];
        }
    }
}

@end