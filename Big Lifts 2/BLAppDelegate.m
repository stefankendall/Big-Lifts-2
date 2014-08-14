#import <Crashlytics/Crashlytics.h>
#import "BLAppDelegate.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"
#import "Migrator.h"
#import "BLTimer.h"
#import "BLKeyValueStore.h"
#import "Flurry.h"

@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[BLJStoreManager instance] resetAllStores];
        [[Migrator new] migrateStores];
        [[BLJStoreManager instance] loadStores];
    });
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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[BLTimer instance] suspend];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    @try {
        [[BLJStoreManager instance] syncStores];
    }
    @catch (NSException *e) {
        NSLog(@"Couldn't sync?");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[BLTimer instance] resume];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end