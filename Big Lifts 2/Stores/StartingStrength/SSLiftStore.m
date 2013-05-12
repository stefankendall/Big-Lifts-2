#import "SSLiftStore.h"

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
    if ([[self findAll] count] == 0) {

    }
}


@end