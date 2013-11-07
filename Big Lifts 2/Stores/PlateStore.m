#import "PlateStore.h"
#import "Plate.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation PlateStore

- (void)onLoad {
    [[SettingsStore instance] registerChangeListener:^{
        [self adjustForKg];
    }];
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
    Plate *p = [self create];
    p.weight = weight;
    p.count = [NSNumber numberWithInt:count];
}

- (NSArray *)findAll {
    return [super findAllWithSort:[[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO]];
}

- (void)adjustForKg {
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"]) {
        Plate *firstPlate = [self first];
        if ([firstPlate.weight doubleValue] == 45.0) {
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