#import "Migrate17to18.h"
#import "JFTOSSTLiftStore.h"
#import "JDataHelper.h"
#import "JFTOTriumvirateStore.h"

@implementation Migrate17to18

- (void)run {
    [JDataHelper write:[JFTOTriumvirateStore instance] values:@[]];
}

@end