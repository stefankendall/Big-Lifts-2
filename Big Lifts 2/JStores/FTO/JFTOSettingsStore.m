#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"

@implementation JFTOSettingsStore

- (Class)modelClass {
    return JFTOSettings.class;
}

- (void)setupDefaults {
    JFTOSettings *settings = [self create];
    settings.trainingMax = N(90);
    settings.warmupEnabled = YES;
    settings.logState = [NSNumber numberWithInt:kShowWorkSets];
    settings.repsToBeatConfig = [NSNumber numberWithInt:kRepsToBeatEverything];
}

@end