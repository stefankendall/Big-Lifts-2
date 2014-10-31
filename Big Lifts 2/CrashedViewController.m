#import "CrashedViewController.h"
#import "DataLoaded.h"
#import "BLJStoreManager.h"
#import "CrashCounter.h"
#import "Migrator.h"

@implementation CrashedViewController

- (IBAction)resetData:(id)sender {
    [CrashCounter resetCrashCounter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[BLJStoreManager instance] resetAllStores];
        [[BLJStoreManager instance] syncStores];
        [[DataLoaded instance] setLoaded:YES];
    });
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)retryToStart:(id)sender {
    [CrashCounter resetCrashCounter];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [[Migrator new] migrateStores];
        [[BLJStoreManager instance] loadStores];
    });
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end