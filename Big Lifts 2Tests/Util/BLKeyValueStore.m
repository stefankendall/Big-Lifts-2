#import "BLKeyValueStore.h"

@implementation BLKeyValueStore

+ (NSUbiquitousKeyValueStore *)store {
    static NSUbiquitousKeyValueStore *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [self iCloudEnabled] ? [NSUbiquitousKeyValueStore defaultStore] : [NSUserDefaults standardUserDefaults];
    });

    return instance;
}

+ (BOOL)iCloudEnabled {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"useIcloud"] != nil) {
        BOOL enabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"useIcloud"];
        return enabled;
    }

    return [[NSFileManager defaultManager] ubiquityIdentityToken] != nil;
}

+ (void)forceICloud:(BOOL)on {
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:@"useIcloud"];
}

@end