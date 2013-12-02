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

- (void)adjustForKg {
    if ([[[[JSettingsStore instance] first] units] isEqualToString:@"kg"]) {
        JBar *bar = [self first];
        bar.weight = N(20);
    }
}

@end