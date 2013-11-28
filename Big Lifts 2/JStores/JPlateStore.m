#import "JPlateStore.h"
#import "JPlate.h"

@implementation JPlateStore

- (Class)modelClass {
    return JPlate.class;
}

- (void)setupDefaults {
    [self createPlateWithWeight:N(45) count:6];
    [self createPlateWithWeight:N(35) count:6];
    [self createPlateWithWeight:N(25) count:6];
    [self createPlateWithWeight:N(10) count:6];
    [self createPlateWithWeight:N(5) count:6];
    [self createPlateWithWeight:N(2.5) count:6];
}

- (void)createPlateWithWeight:(NSDecimalNumber *)weight count:(int)count {
    JPlate *p = [self create];
    p.weight = weight;
    p.count = [NSNumber numberWithInt:count];
}

- (NSArray *)findAll {
    NSArray *sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO]];
    NSArray *dataSortedByWeight = [self.data sortedArrayUsingDescriptors:sortDescriptors];
    return dataSortedByWeight;
}

- (void)adjustForKg {
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

@end