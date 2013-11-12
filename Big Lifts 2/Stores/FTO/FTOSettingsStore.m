#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTOSettingsStore

- (void)setupDefaults {
    FTOSettings *settings = [self create];
    settings.trainingMax = N(90);
    settings.warmupEnabled = YES;
    settings.logState = [NSNumber numberWithInt:kShowWorkSets];
    settings.repsToBeatConfig = [NSNumber numberWithInt:kRepsToBeatEverything];
}

- (void)onLoad {
    FTOSettings *settings = [self first];
    if (settings.repsToBeatConfig == nil ) {
        settings.repsToBeatConfig = [NSNumber numberWithInt:kRepsToBeatEverything];
    }
}


@end