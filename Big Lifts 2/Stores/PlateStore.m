#import "PlateStore.h"
#import "Plate.h"
#import "SettingsStore.h"

@implementation PlateStore

- (void)onLoad {
    [[SettingsStore instance] registerChangeListener:^{
        [self adjustForKg];
    }];
}

- (void)setupDefaults {
    [self createPlateWithWeight:@"45.0" count:6];
    [self createPlateWithWeight:@"35.0" count:6];
    [self createPlateWithWeight:@"25.0" count:6];
    [self createPlateWithWeight:@"10.0" count:6];
    [self createPlateWithWeight:@"5.0" count:6];
    [self createPlateWithWeight:@"2.5" count:6];
}

- (void)createPlateWithWeight:(NSString *)weight count:(int)count {
    Plate *p = [self create];
    p.weight = [NSDecimalNumber decimalNumberWithString:weight];
    p.count = [NSNumber numberWithInt:count];
}

- (NSArray *)findAll {
    return [super findAllWithSort:[[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO]];
}

- (void)adjustForKg {
    Plate *firstPlate = [self first];
    if ([firstPlate.weight doubleValue] == 45.0) {
        [self empty];
        [self createPlateWithWeight:@"20.0" count:6];
        [self createPlateWithWeight:@"15.0" count:6];
        [self createPlateWithWeight:@"10.0" count:6];
        [self createPlateWithWeight:@"5.0" count:6];
        [self createPlateWithWeight:@"2.5" count:6];
        [self createPlateWithWeight:@"1" count:6];
    }
}

@end