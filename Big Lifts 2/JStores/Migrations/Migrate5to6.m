#import "Migrate5to6.h"
#import "JFTOTriumvirateStore.h"

@implementation Migrate5to6

- (void)run {
    [[JFTOTriumvirateStore instance] adjustToMainLifts];
}

@end