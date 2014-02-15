#import "Migrate8to9.h"
#import "JFTOSettings.h"
#import "JFTOSettingsHelper.h"

@implementation Migrate8to9

- (void)run {
    NSMutableDictionary *settings = [JFTOSettingsHelper readSettings];
    if (settings) {
        settings[@"sixWeekEnabled"] = @0;
        [JFTOSettingsHelper writeSettings:settings];
    }
}

@end