#import "JBarStore.h"
#import "JBar.h"
#import "JSettings.h"
#import "JSettingsStore.h"

@implementation JBarStore

- (Class)modelClass {
    return JBar.class;
}

- (void)setupDefaults {
    JBar *bar = [self create];
    bar.weight = N(45);
}

- (void)adjustWeightForKg {
    JBar *bar = [self first];
    JSettings *settings = [[JSettingsStore instance] first];
    if ([settings.units isEqualToString:@"kg"]) {
        bar.weight = N(20);
    }
}

@end