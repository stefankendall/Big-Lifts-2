@class BLStore;

@interface BLStoreManager : NSObject

+ (BLStoreManager *)instance;

- (void)initializeAllStores;

- (NSMutableSet *)getChangedModelNames:(NSSet *)allObjects;

- (NSSet *)getChangedStoresFromObjects:(NSSet *)allObjects;

@property(nonatomic, strong) NSArray *allStores;

@end