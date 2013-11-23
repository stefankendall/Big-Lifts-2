@class BLJStore;

@interface BLJStoreManager : NSObject

+ (BLJStoreManager *)instance;

- (void)initializeAllStores;

- (void)resetAllStores;

@property(nonatomic, strong) NSArray *allStores;
@end