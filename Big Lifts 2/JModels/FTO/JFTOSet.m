#import "JFTOSet.h"
#import "JLift.h"
#import "JBar.h"
#import "JBarStore.h"
#import "JFTOSettings.h"
#import "JFTOSettingsStore.h"
#import "DecimalNumberHandlers.h"

@implementation JFTOSet

- (NSDecimalNumber *)effectiveWeight {
    JFTOSettings *settings = [[JFTOSettingsStore instance] first];
    NSDecimalNumber *setEffectiveWeight = [super effectiveWeight];
    NSDecimalNumber *effectiveWeight = [
            [setEffectiveWeight decimalNumberByMultiplyingBy:settings.trainingMax withBehavior:DecimalNumberHandlers.noRaise]
            decimalNumberByDividingBy:N(100) withBehavior:DecimalNumberHandlers.noRaise];

    if (self.lift.usesBar) {
        JBar *bar = [[JBarStore instance] first];
        if ([effectiveWeight compare:bar.weight] == NSOrderedAscending) {
            return bar.weight;
        }
    }

    return effectiveWeight;
}

@end