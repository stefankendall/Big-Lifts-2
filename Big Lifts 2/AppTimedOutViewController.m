#import "AppTimedOutViewController.h"
#import "BLJStoreManager.h"
#import "DataLoaded.h"

@implementation AppTimedOutViewController

- (IBAction)resetData:(id)sender {
    [[BLJStoreManager instance] resetAllStores];
    [[BLJStoreManager instance] syncStores];
    [[DataLoaded instance] setLoaded:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end