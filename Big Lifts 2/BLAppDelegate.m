#import "BLAppDelegate.h"
#import "SKProductStore.h"
#import "BLStoreManager.h"
#import "Flurry.h"
#import "DataLoadingViewController.h"

@interface BLAppDelegate ()
@property(nonatomic, strong) NSManagedObjectContext *moc;
@end

@implementation BLAppDelegate

@synthesize manager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    manager = [[UbiquityStoreManager alloc] initStoreNamed:nil
                                    withManagedObjectModel:nil
                                             localStoreURL:nil
                                       containerIdentifier:nil
                                    additionalStoreOptions:nil
                                                  delegate:self];
    manager.cloudEnabled = YES;
    [[SKProductStore instance] loadProducts:^{
    }];
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"FW43KTWNCSNYJRDR39WY"];
    return YES;
}

- (void)cloudDidSync {
    [[BLStoreManager instance] dataWasSynced];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self beginBackgroundUpdateTask];
        [self saveContext];
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

- (void)saveContext {
    NSError *error = nil;
    if (self.moc != nil) {
        if ([self.moc hasChanges] && ![self.moc save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
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
    [self.moc setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    [self loadData];
}

- (void)loadData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storesLoaded) name:@"storesLoaded" object:nil];
    [[BLStoreManager instance] initializeAllStores:self.moc withModel:[[self.moc persistentStoreCoordinator] managedObjectModel]];
}

- (void)storesLoaded {
    UINavigationController *navController = (UINavigationController *) self.window.rootViewController;
    DataLoadingViewController *controller = (DataLoadingViewController *) navController.viewControllers[0];
    controller.dataLoaded = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cloudDidSync) name:USMStoreDidImportChangesNotification object:nil];
}

- (NSManagedObjectContext *)managedObjectContextForUbiquityChangesInManager:(UbiquityStoreManager *)manager1 {
    return self.moc;
}

@end