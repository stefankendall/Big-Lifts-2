#import "BLKeyValueStore.h"

@implementation BLKeyValueStore

+ (NSUbiquitousKeyValueStore *)store {
    return [self iCloudEnabled] ? [NSUbiquitousKeyValueStore defaultStore] : [NSUserDefaults standardUserDefaults];
}

+ (BOOL)iCloudEnabled {
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    return ubiq != nil;
}

@end