#import "JFTOSettingsStore.h"
#import "JFTOSettings.h"
#import "DecimalNumberHelper.h"

@implementation JFTOSettingsStore

- (Class)modelClass {
    return JFTOSettings.class;
}

- (void)onLoad {
    JFTOSettings *settings = [self first];
    settings.trainingMax = [DecimalNumberHelper nanOrNil:settings.trainingMax to:N(90)];
}

- (void)setupDefaults {
    JFTOSettings *settings = [self create];
    settings.trainingMax = N(90);
    settings.warmupEnabled = YES;
    settings.sixWeekEnabled = NO;
    settings.logState = [NSNumber numberWithInt:kShowWorkSets];
    settings.repsToBeatConfig = [NSNumber numberWithInt:kRepsToBeatEverything];
}

@end