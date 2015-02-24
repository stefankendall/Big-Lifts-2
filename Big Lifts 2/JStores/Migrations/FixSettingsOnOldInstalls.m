#import "FixSettingsOnOldInstalls.h"
#import "JSettingsHelper.h"

@implementation FixSettingsOnOldInstalls

- (void)run {
    [self fixStore:[NSUserDefaults standardUserDefaults]];
    [self fixStore:[NSUbiquitousKeyValueStore defaultStore]];
}

- (void)fixStore:(id)store {
    NSMutableDictionary *settings = [JSettingsHelper readSettings:store];
    if(settings == nil){
        return;
    }

    if (settings[@"isMale"] == nil) {
        settings[@"isMale"] = @1;
    }
    if (settings[@"barLoadingEnabled"] == nil) {
        settings[@"barLoadingEnabled"] = @1;
    }
    if (settings[@"bodyweight"] == nil) {
        settings[@"bodyweight"] = @"";
    }
    [JSettingsHelper writeSettings:settings forStore:store];
}

@end