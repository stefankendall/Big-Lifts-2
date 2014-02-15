#import "Migrate7to8.h"
#import "JSettingsHelper.h"

@implementation Migrate7to8

- (void)run {
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    if (settings) {
        settings[@"adsEnabled"] = @0;
        [JSettingsHelper writeSettings:settings];
    }
}


@end