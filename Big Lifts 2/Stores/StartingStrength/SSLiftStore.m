#import "SSLiftStore.h"
#import "ContextManager.h"
#import "SSLift.h"

@implementation SSLiftStore {
}

- (NSString *)modelName {
    return @"SSLift";
}

+ (SSLiftStore *)instance {
    static SSLiftStore *store = nil;
    if (!store) {
        store = (SSLiftStore *) [[super allocWithZone:nil] init];
        [store setupDefaults];
    }
    return store;
}

- (void)setupDefaults {
    if ([self count] == 0) {
        [self createLift:@"Bench" withOrder:0];
        [self createLift:@"Deadlift" withOrder:1];
        [self createLift:@"Power Clean" withOrder:2];
        [self createLift:@"Press" withOrder:3];
        [self createLift:@"Squat" withOrder:4];
    }
}

- (void)createLift:(NSString *)name withOrder:(double)order {
    SSLift *lift = [NSEntityDescription insertNewObjectForEntityForName:@"SSLift" inManagedObjectContext:[ContextManager context]];
    [lift setName:name];
    [lift setOrder:[NSNumber numberWithDouble:order]];
}


@end