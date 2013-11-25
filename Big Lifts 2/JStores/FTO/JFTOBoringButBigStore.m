#import "JFTOBoringButBigStore.h"
#import "JFTOBoringButBig.h"

@implementation JFTOBoringButBigStore

- (Class)modelClass {
    return JFTOBoringButBig.class;
}

- (void)setupDefaults {
    JFTOBoringButBig *bbbPercentage = [self create];
    bbbPercentage.percentage = N(50);
    bbbPercentage.threeMonthChallenge = NO;
}

@end