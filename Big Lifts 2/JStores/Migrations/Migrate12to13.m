#import "Migrate12to13.h"
#import "JSettingsHelper.h"
#import "JSettings.h"

@implementation Migrate12to13

- (void)run {
    [self addRoundingTypeToSettings];
}

- (void)addRoundingTypeToSettings {
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    if (settings) {
        if (![[settings allKeys] containsObject:@"roundingType"]) {
            settings[@"roundingType"] = ROUNDING_TYPE_NORMAL;
        }
        [JSettingsHelper writeSettings:settings];
    }
}

@end