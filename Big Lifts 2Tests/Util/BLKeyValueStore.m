#import "BLKeyValueStore.h"

@implementation BLKeyValueStore

+ (NSUbiquitousKeyValueStore *)store {
    return [self iCloudEnabled] ? [NSUbiquitousKeyValueStore defaultStore] : [NSUserDefaults standardUserDefaults];
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