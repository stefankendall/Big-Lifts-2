#import "SSLiftStore.h"
#import "SSLift.h"
#import "BLStoreManager.h"
#import "SettingsStore.h"
#import "Settings.h"

@implementation SSLiftStore {
}

- (void)setupDefaults {
    if ([self count] == 0) {
        [self createLift:@"Bench" withOrder:0 withIncrement:5];
        [self createLift:@"Deadlift" withOrder:1 withIncrement:10];
        [self createLift:@"Power Clean" withOrder:2 withIncrement:5];
        [self createLift:@"Press" withOrder:3 withIncrement:5];
        [self createLift:@"Squat" withOrder:4 withIncrement:10];
    }
}

- (void)onLoad {
    [[SettingsStore instance] registerChangeListener:^{
        [self adjustForKg];
    }];
}

- (void)createLift:(NSString *)name withOrder:(double)order withIncrement:(int)increment {
    SSLift *lift = [NSEntityDescription insertNewObjectForEntityForName:@"SSLift" inManagedObjectContext:[BLStoreManager context]];
    [lift setName:name];
    [lift setOrder:[NSNumber numberWithDouble:order]];
    [lift setIncrement:[NSNumber numberWithInt:increment]];
}

- (void)adjustForKg {
    Settings *settings = [[SettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"]) {
        SSLift *bench = [[SSLiftStore instance] find:@"name" value:@"Bench"];
        SSLift *squat = [[SSLiftStore instance] find:@"name" value:@"Squat"];
        SSLift *deadlift = [[SSLiftStore instance] find:@"name" value:@"Deadlift"];
        SSLift *powerClean = [[SSLiftStore instance] find:@"name" value:@"Power Clean"];
        SSLift *press = [[SSLiftStore instance] find:@"name" value:@"Press"];

        bench.increment = [bench.increment doubleValue] == 5.0 ? @2 : bench.increment;
        squat.increment = [bench.increment doubleValue] == 10.0 ? @5 : squat.increment;
        deadlift.increment = [bench.increment doubleValue] == 10.0 ? @5 : deadlift.increment;
        powerClean.increment = [bench.increment doubleValue] == 5.0 ? @2 : powerClean.increment;
        press.increment = [bench.increment doubleValue] == 5.0 ? @2 : press.increment;
    }
}
@end