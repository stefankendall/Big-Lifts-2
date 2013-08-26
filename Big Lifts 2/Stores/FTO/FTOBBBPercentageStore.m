#import "FTOBBBPercentageStore.h"
#import "FTOBBBPercentage.h"

@implementation FTOBBBPercentageStore

- (void)setupDefaults {
    FTOBBBPercentage *bbbPercentage = [self create];
    bbbPercentage.percentage = N(50);
}

@end