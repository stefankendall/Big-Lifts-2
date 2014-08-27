#import "Migrate16to17.h"
#import "JDataHelper.h"
#import "JSettingsStore.h"

@implementation Migrate16to17

- (void)run {
    [self addBarLoadingEnabledPropertyToSettings];
}

- (void)addBarLoadingEnabledPropertyToSettings {
    NSArray *settingsArray = [JDataHelper read:[JSettingsStore instance]];
    NSMutableDictionary *settings = settingsArray[0];
    settings[@"barLoadingEnabled"] = @1;
    [JDataHelper write:[JSettingsStore instance] values:settingsArray];
}

@end