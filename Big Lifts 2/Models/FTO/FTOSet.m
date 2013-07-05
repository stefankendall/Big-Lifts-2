#import "FTOSet.h"
#import "FTOSettings.h"
#import "FTOSettingsStore.h"

@implementation FTOSet

- (NSDecimalNumber *)effectiveWeight {
    FTOSettings *settings = [[FTOSettingsStore instance] first];
    return [[[super effectiveWeight] decimalNumberByMultiplyingBy:settings.trainingMax]
            decimalNumberByDividingBy:N(100)];
}

@end