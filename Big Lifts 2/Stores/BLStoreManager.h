@class BLStore;

@interface BLStoreManager : NSObject

+ (BLStoreManager *)instance;

+ (NSManagedObjectContext *)context;

+ (NSManagedObjectModel *)model;

- (void)initializeAllStores:(NSManagedObjectContext *)context withModel:(NSManagedObjectModel *)model;

- (void)resetAllStores;

- (NSMutableSet *)getChangedModelNames:(NSSet *)allObjects;

- (NSSet *)getChangedStoresFromObjects:(NSSet *)allObjects;

@property(nonatomic, strong) NSArray *allStores;

- (void)saveChanges;

@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic, strong) NSManagedObjectModel *model;


@end