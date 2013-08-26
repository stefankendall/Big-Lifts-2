#import "FTOBoringButBigStore.h"
#import "FTOBoringButBig.h"

@implementation FTOBoringButBigStore

- (void)setupDefaults {
    FTOBoringButBig *bbbPercentage = [self create];
    bbbPercentage.percentage = N(50);
    bbbPercentage.threeMonthChallenge = NO;
}

@end