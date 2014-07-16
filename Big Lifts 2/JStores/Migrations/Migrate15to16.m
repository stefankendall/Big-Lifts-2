#import "Migrate15to16.h"
#import "JFTOSetStore.h"
#import "JFTOSSTLiftStore.h"
#import "JDataHelper.h"

@implementation Migrate15to16

- (void)run {
    [self addUsesBarToSstLifts];
}

- (void)addUsesBarToSstLifts {
    NSMutableArray *allData = [JDataHelper read:[JFTOSSTLiftStore instance]];
    for (NSMutableDictionary *data in allData) {
        data[@"usesBar"] = @1;
    }
    [JDataHelper write:[JFTOSSTLiftStore instance] values:allData];
}

@end