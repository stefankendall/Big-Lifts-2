#import <Crashlytics/Crashlytics.h>
#import "BLAppDelegate.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"
#import "Migrator.h"
#import "BLTimer.h"
#import "BLKeyValueStore.h"
#import "Flurry.h"
#import "CrashCounter.h"

@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [CrashCounter incrementCrashCounter];
    [Flurry setCrashReportingEnabled:NO];
    [Flurry startSession:@"FW43KTWNCSNYJRDR39WY"];
#if (!TARGET_IPHONE_SIMULATOR)
    [Crashlytics startWithAPIKey:@"f1f936528fec614b3f5e265a22c4bef0a92d8dc4"];
#endif

    [[SKProductStore instance] loadProducts:^{
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyValueStoreChanged:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:nil];
    [[BLKeyValueStore store] synchronize];

    if ([CrashCounter crashCount] <= 1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [[Migrator new] migrateStores];
            [[BLJStoreManager instance] loadStores];
        });
    }

    return YES;
}

- (void)keyValueStoreChanged:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    switch ([[userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey] integerValue]) {
        case NSUbiquitousKeyValueStoreServerChange:
            break;
        case NSUbiquitousKeyValueStoreInitialSyncChange:
            [Flurry logEvent:@"iCloud_InitialSync"];
            break;
        case NSUbiquitousKeyValueStoreQuotaViolationChange:
            [Flurry logEvent:@"iCloud_QuotaViolation"];
            break;
        case NSUbiquitousKeyValueStoreAccountChange:
            [Flurry logEvent:@"iCloud_AccountChange"];
            break;
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[BLTimer instance] suspend];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIBackgroundTaskIdentifier __block bgTask = nil;
    UIApplication *app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[BLJStoreManager instance] syncStores];
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[BLTimer instance] resume];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end