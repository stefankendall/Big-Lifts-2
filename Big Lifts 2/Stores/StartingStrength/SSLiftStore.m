#import "SSLiftStore.h"
#import "SSLift.h"
#import "BLStoreManager.h"

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

- (void)createLift:(NSString *)name withOrder:(double)order withIncrement:(int)increment {
    SSLift *lift = [NSEntityDescription insertNewObjectForEntityForName:@"SSLift" inManagedObjectContext:[BLStoreManager context]];
    [lift setName:name];
    [lift setOrder:[NSNumber numberWithDouble:order]];
    [lift setIncrement:[NSNumber numberWithInt:increment]];
}


@end