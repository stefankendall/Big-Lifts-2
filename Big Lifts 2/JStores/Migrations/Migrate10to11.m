#import "Migrate10to11.h"
#import "JFTOSettingsHelper.h"
#import "JSettings.h"
#import "JSettingsHelper.h"

@implementation Migrate10to11

- (void)run {
    [self addRoundingTypeToSettings];
}

- (void)addRoundingTypeToSettings {
    NSMutableDictionary *settings = [JSettingsHelper readSettings];
    if (settings) {
        settings[@"roundingType"] = ROUNDING_TYPE_NORMAL;
        [JSettingsHelper writeSettings:settings];
    }
}

@end