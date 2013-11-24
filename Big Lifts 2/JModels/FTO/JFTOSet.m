#import "JFTOSet.h"
#import "JLift.h"
#import "JBar.h"
#import "JBarStore.h"

@implementation JFTOSet

- (NSDecimalNumber *)effectiveWeight {
    JFTOSettings *settings = [[JFTOSettingsStore instance] first];
    NSDecimalNumber *effectiveWeight = [[[super effectiveWeight] decimalNumberByMultiplyingBy:settings.trainingMax]
            decimalNumberByDividingBy:N(100)];

    if (self.lift.usesBar) {
        JBar *bar = [[JBarStore instance] first];
        if ([effectiveWeight compare:bar.weight] == NSOrderedAscending) {
            return bar.weight;
        }
    }

    return effectiveWeight;
}

@end