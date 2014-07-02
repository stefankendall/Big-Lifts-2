@class BLJStore;

@interface BLJStoreManager : NSObject

+ (BLJStoreManager *)instance;

- (void)loadStores;

- (void)syncStores;

- (void)writeStores;

- (void)resetAllStores;

- (void)resetAllStoresExceptLog;

@property(nonatomic, strong) NSArray *allStores;

- (BLJStore *)storeForModel:(Class)pClass withUuid:(NSString *)uuid;

- (id)findModelForClass:(Class)pClass withUuid:(id)uuid;
@end