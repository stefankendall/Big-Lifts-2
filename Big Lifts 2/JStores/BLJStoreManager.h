@class BLJStore;

@interface BLJStoreManager : NSObject

+ (BLJStoreManager *)instance;

- (void)loadStores;

- (void)resetAllStores;

@property(nonatomic, strong) NSArray *allStores;
@end