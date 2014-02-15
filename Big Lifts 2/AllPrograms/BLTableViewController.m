#import <iAd/iAd.h>
#import "BLTableViewController.h"
#import "JSettingsStore.h"
#import "JSettings.h"
#import "AdsOptInDialog.h"
#import "AdsExperiment.h"

@interface BLTableViewController ()
@property(nonatomic, strong) AdsOptInDialog *adsOptInDialog;
@end

@implementation BLTableViewController

- (void)viewDidLoad {
    self.canDisplayBannerAds = [[[JSettingsStore instance] first] adsEnabled];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([AdsExperiment isInExperiment] && ![AdsExperiment hasSeenOptIn]) {
        [AdsExperiment setHasSeenOptIn:YES];
        self.adsOptInDialog = [AdsOptInDialog new];
        [self.adsOptInDialog show];
    }
}


@end