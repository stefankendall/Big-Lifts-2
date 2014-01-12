#import "Migrate4to5.h"
#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"

@implementation Migrate4to5

- (void)run {
    JFTOSettings *settings = [[JFTOSettingsStore instance] first];
    if (!settings.trainingMax) {
        settings.trainingMax = N(90);
    }
}

@end