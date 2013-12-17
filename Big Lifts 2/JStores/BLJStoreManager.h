@class BLJStore;

@interface BLJStoreManager : NSObject

+ (BLJStoreManager *)instance;

- (void)loadStores;

- (void)syncStores;

- (void)resetAllStores;

- (void)resetAllStoresExceptLog;

@property(nonatomic, strong) NSArray *allStores;

- (BLJStore *)storeForModel:(Class)pClass withUuid:(NSString *)uuid;

@end