@class BLJStore;

@interface BLJStoreManager : NSObject

+ (BLJStoreManager *)instance;

- (void)loadStores;

- (void)syncStores;

- (void)writeStores;

- (void)resetAllStores;

@property(nonatomic, strong) NSArray *allStores;

@property(nonatomic) BOOL savingStores;

- (BLJStore *)storeForModel:(Class)pClass withUuid:(NSString *)uuid;

- (id)findModelForClass:(Class)pClass withUuid:(id)uuid;
@end