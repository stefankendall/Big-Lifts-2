#import "BLTableViewController.h"
#import "JSettings.h"
#import "EverythingDialog.h"
#import "Purchaser.h"

@interface BLTableViewController ()
@end

@implementation BLTableViewController

- (void)registerCellNib:(Class)klass {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(klass) bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:NSStringFromClass(klass)];
}

- (void)viewDidAppear:(BOOL)animated {
    NSString *key = @"everythingPurchaseAlert";
    if ([Purchaser hasPurchasedAnything] && ![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        self.everythingDialog = [EverythingDialog new];
        [self.everythingDialog show];
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
}

@end