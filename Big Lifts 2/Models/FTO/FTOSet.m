#import "FTOSet.h"
#import "FTOSettings.h"
#import "FTOSettingsStore.h"
#import "BarStore.h"
#import "Bar.h"
#import "Lift.h"

@implementation FTOSet

- (NSDecimalNumber *)effectiveWeight {
    FTOSettings *settings = [[FTOSettingsStore instance] first];
    NSDecimalNumber *effectiveWeight = [[[super effectiveWeight] decimalNumberByMultiplyingBy:settings.trainingMax]
            decimalNumberByDividingBy:N(100)];

    if (self.lift.usesBar) {
        Bar *bar = [[BarStore instance] first];
        if ([effectiveWeight compare:bar.weight] == NSOrderedAscending) {
            return bar.weight;
        }
    }

    return effectiveWeight;
}

@end