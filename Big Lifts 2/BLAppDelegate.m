#import <Crashlytics/Crashlytics.h>
#import "BLAppDelegate.h"
#import "SKProductStore.h"
#import "BLJStoreManager.h"

@interface BLAppDelegate ()
@property(nonatomic, strong) NSManagedObjectContext *moc;
@end

@implementation BLAppDelegate

@synthesize manager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if (!TARGET_IPHONE_SIMULATOR)
    [Crashlytics startWithAPIKey:@"f1f936528fec614b3f5e265a22c4bef0a92d8dc4"];
#endif
//    manager = [[UbiquityStoreManager alloc] initStoreNamed:nil
//                                    withManagedObjectModel:nil
//                                             localStoreURL:nil
//                                       containerIdentifier:nil
//                                    additionalStoreOptions:nil
//                                                  delegate:self];
//    manager.cloudEnabled = YES;
    [[SKProductStore instance] loadProducts:^{
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyValueStoreChanged:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:nil];
    //hack to get callback to fire.
    [[NSUbiquitousKeyValueStore defaultStore] setString:@"testValue" forKey:@"testKey"];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    [[BLJStoreManager instance] loadStores];
    return YES;
}

- (void)keyValueStoreChanged:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)ubiquityStoreManager:(UbiquityStoreManager *)manager willLoadStoreIsCloud:(BOOL)isCloudStore {
    self.moc = nil;
}

- (BOOL)                ubiquityStoreManager:(UbiquityStoreManager *)manager
handleCloudContentCorruptionWithHealthyStore:(BOOL)storeHealthy {
    return NO;
}

- (void)ubiquityStoreManager:(UbiquityStoreManager *)manager didLoadStoreForCoordinator:(NSPersistentStoreCoordinator *)coordinator isCloud:(BOOL)isCloudStore {
    self.moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.moc setPersistentStoreCoordinator:coordinator];
    [self.moc setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    [self loadData];
}

- (void)loadData {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storesLoaded) name:@"storesLoaded" object:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [[BLStoreManager instance] initializeAllStores:self.moc withModel:[[self.moc persistentStoreCoordinator] managedObjectModel]];
//    });
}

- (NSManagedObjectContext *)managedObjectContextForUbiquityChangesInManager:(UbiquityStoreManager *)manager1 {
    return self.moc;
}

@end