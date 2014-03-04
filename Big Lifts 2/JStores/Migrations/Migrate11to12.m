#import "Migrate11to12.h"
#import "JSettingsHelper.h"

@implementation Migrate11to12

- (void)run {
    [self removeAdsOnFromSettings];
}

- (void)removeAdsOnFromSettings {
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    [settings removeObjectForKey:@"adsEnabled"];
    [JSettingsHelper writeSettings:settings];
}

@end