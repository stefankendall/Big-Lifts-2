#import "Migrate6to7.h"
#import "JSettingsHelper.h"

@implementation Migrate6to7

- (void)run {
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    if (settings) {
        settings[@"isMale"] = @1;
        [JSettingsHelper writeSettings:settings];
    }
}

@end