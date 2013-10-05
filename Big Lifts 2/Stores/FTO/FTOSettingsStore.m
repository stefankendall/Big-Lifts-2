#import "FTOSettingsStore.h"
#import "FTOSettings.h"

@implementation FTOSettingsStore

- (void)setupDefaults {
    FTOSettings *settings = [self create];
    settings.trainingMax = N(90);
    settings.warmupEnabled = YES;
    settings.logState = [NSNumber numberWithInt:kShowWorkSets];
}

@end