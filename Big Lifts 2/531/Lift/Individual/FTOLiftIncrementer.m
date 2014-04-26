#import "FTOLiftIncrementer.h"
#import "JFTOSSTLiftStore.h"
#import "JFTOLiftStore.h"

@implementation FTOLiftIncrementer

- (void) incrementLifts {
    [[JFTOLiftStore instance] incrementLifts];
    [[JFTOSSTLiftStore instance] incrementLifts];
}

@end