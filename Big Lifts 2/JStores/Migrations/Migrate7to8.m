#import "Migrate7to8.h"
#import "JSettingsHelper.h"
#import "AdsExperiment.h"

@implementation Migrate7to8

- (void)run {
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    if (settings) {
        settings[@"adsEnabled"] = @0;
        [JSettingsHelper writeSettings:settings];
        [AdsExperiment placeInExperimentOrNot];
    }
}


@end