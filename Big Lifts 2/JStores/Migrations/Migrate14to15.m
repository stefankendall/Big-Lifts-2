#import "JSetLog.h"
#import "Migrate14to15.h"
#import "JFTOLiftStore.h"
#import "JDataHelper.h"
#import "JFTOSetStore.h"

@implementation Migrate14to15

- (void)run {
    [self removeDeadLiftsFromFtoSet];
}

- (void)removeDeadLiftsFromFtoSet {
    NSArray *allFtoSetLiftUuids = [self getAllUuids];
    NSArray *allSetData = [JDataHelper read:[JFTOSetStore instance]];
    for (NSMutableDictionary *setData in allSetData) {
        if (![allFtoSetLiftUuids containsObject:setData[@"lift"]]) {
            setData[@"lift"] = [NSNull new];
        }
    }
    [JDataHelper write:[JFTOSetStore instance] values:allSetData];
}

- (NSArray *)getAllUuids {
    NSMutableArray *uuids = [@[] mutableCopy];

    for (BLJStore *store in [self liftStores]) {
        NSArray *data = [JDataHelper read:store];
        for (NSDictionary *model in data) {
            [uuids addObject:model[@"uuid"]];
        }
    }
    return uuids;
}

- (NSArray *)liftStores {
    return @[[JLiftStore instance], [JFTOLiftStore instance]];
}

@end