#import "Migrate10to11.h"
#import "JFTOSettingsHelper.h"
#import "JSettings.h"

@implementation Migrate10to11

- (void)run {
    [self addRoundingTypeToSettings];
}

- (void)addRoundingTypeToSettings {
    NSMutableDictionary *settings = [JFTOSettingsHelper readSettings];
    if (settings) {
        settings[@"roundingType"] = ROUNDING_TYPE_NORMAL;
        [JFTOSettingsHelper writeSettings:settings];
    }
}

@end