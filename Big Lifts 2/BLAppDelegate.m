#import <Crashlytics/Crashlytics.h>
#import "BLAppDelegate.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"
#import "Migrator.h"
#import "BLTimer.h"
#import "DataLoadingViewController.h"

@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if (!TARGET_IPHONE_SIMULATOR)
    [Crashlytics startWithAPIKey:@"f1f936528fec614b3f5e265a22c4bef0a92d8dc4"];
#endif
    [[SKProductStore instance] loadProducts:^{
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyValueStoreChanged:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:nil];
    //hack to get callback to fire.
    [[NSUbiquitousKeyValueStore defaultStore] setString:@"testValue" forKey:@"testKey"];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allDataLoaded) name:@"jstoresLoaded" object:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[Migrator new] migrateStores];
        [[BLJStoreManager instance] loadStores];
    });
    return YES;
}

- (void)allDataLoaded {
    UINavigationController *navController = (UINavigationController *) self.window.rootViewController;
    DataLoadingViewController *controller = (DataLoadingViewController *) navController.viewControllers[0];
    controller.dataLoaded = YES;
}

- (void)keyValueStoreChanged:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[BLTimer instance] suspend];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self beginBackgroundUpdateTask];
        @try {
            [[BLJStoreManager instance] syncStores];
        }
        @catch (NSException *e) {
            NSLog(@"Couldn't sync?");
        }
        [self endBackgroundUpdateTask];
    });
}

- (void)beginBackgroundUpdateTask {
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask {
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
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