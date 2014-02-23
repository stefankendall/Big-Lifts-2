#import "JSettings.h"
#import "JSettingsStore.h"
#import "JFTOLiftStore.h"
#import "JSSLiftStore.h"
#import "JSJWorkoutStore.h"
#import "JPlateStore.h"
#import "JBarStore.h"
#import "JSVWorkoutStore.h"

const NSString *ROUNDING_FORMULA_EPLEY = @"Epley";
const NSString *ROUNDING_FORMULA_BRZYCKI = @"Brzycki";

const NSString *ROUNDING_TYPE_NORMAL = @"Normal";

NSString *NEAREST_5_ROUNDING = @"5.5";

@implementation JSettings

- (void)setUnits:(NSString *)units {
    _units = units;
    [[JSettingsStore instance] adjustForKg];
    [[JPlateStore instance] adjustForKg];
    [[JBarStore instance] adjustForKg];
    [[JFTOLiftStore instance] adjustForKg];
    [[JSSLiftStore instance] adjustForKg];
    [[JSJWorkoutStore instance] adjustForKg];
    [[JSVWorkoutStore instance] adjustForKg];
}

- (void)setScreenAlwaysOn:(BOOL)screenAlwaysOn {
    _screenAlwaysOn = screenAlwaysOn;
    [[UIApplication sharedApplication] setIdleTimerDisabled:screenAlwaysOn];
}

@end