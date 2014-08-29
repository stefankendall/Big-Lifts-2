#import "Migrate16to17.h"
#import "JDataHelper.h"
#import "JSettingsStore.h"

@implementation Migrate16to17

- (void)run {
    [self addBarLoadingEnabledPropertyToSettings];
}

- (void)addBarLoadingEnabledPropertyToSettings {
    NSMutableArray *settingsArray = [JDataHelper read:[JSettingsStore instance]];
    if ([settingsArray count] > 0) {
        NSMutableDictionary *settings = settingsArray[0];
        if (settings != nil) {
            settings[@"barLoadingEnabled"] = @1;
            [JDataHelper write:[JSettingsStore instance] values:settingsArray];
        }
    }
}

@end