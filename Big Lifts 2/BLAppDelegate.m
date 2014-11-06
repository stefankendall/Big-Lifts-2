#import <Crashlytics/Crashlytics.h>
#import "BLAppDelegate.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"
#import "Migrator.h"
#import "BLTimer.h"
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

    [[NSUbiquitousKeyValueStore defaultStore] synchronize];

    if ([CrashCounter crashCount] <= 1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [[Migrator new] migrateStores];
            [[BLJStoreManager instance] loadStores];
        });
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[BLTimer instance] suspend];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[BLJStoreManager instance] syncStores];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[BLTimer instance] resume];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[BLJStoreManager instance] syncStores];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end