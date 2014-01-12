#import "Migrate3to4.h"
#import "JBarStore.h"
#import "JBar.h"

@implementation Migrate3to4

- (void)run {
    JBar *bar = [[JBarStore instance] first];
    if( !bar.weight ){
        bar.weight = N(0);
    }
}

@end