@class BLJStore;

@interface BLJStoreManager : NSObject

+ (BLJStoreManager *)instance;

- (void)loadStores;

- (void)syncStores;

- (void)resetAllStores;

@property(nonatomic, strong) NSArray *allStores;
@end