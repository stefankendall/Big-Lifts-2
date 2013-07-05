#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTOSettingsStore

- (void)setupDefaults {
    FTOSettings *settings = [self create];
    settings.trainingMax = N(90);
}

@end