#import <iAd/iAd.h>
#import "BLTableViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation BLTableViewController

- (void)viewDidLoad {
    self.canDisplayBannerAds = [[[JSettingsStore instance] first] adsEnabled];
}

@end