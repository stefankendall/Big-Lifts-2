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

    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    return ubiq != nil;
}

+ (void)forceICloud:(BOOL)on {
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:@"useIcloud"];
}

@end