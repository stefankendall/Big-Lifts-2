@class JSONModel;

@interface BLJStore : NSObject

- (Class)modelClass;

- (id)create;

- (void)buildUuidCache;

- (void)empty;

- (void)remove:(id)object;

- (void)reset;

- (NSMutableArray *)deserialize:(NSArray *)serialized;

- (JSONModel *)deserializeObject:(NSString *)string;

- (void)setupDefaults;

- (void)setDefaultsForObject:(id)object;

- (id)first;

- (id)last;

- (id)find:(NSString *)name value:(id)value;

- (NSArray *)findAll;

- (NSArray *)findAllWhere:(NSString *)name value:(id)value;

- (id)findBy:(NSPredicate *)predicate;

- (id)atIndex:(int)index;

- (NSNumber *)max:(NSString *)property;

- (void)removeAtIndex:(int)index;

- (void)removeAll;

- (int)count;

- (NSOrderedSet *)unique:(NSString *)string;

+ (instancetype)instance;

- (NSArray *)serializeAndCache;

- (void)onLoad;

- (void)clearSyncCache;

- (void)sync;

- (void)load:(id)store;

- (NSString *)keyNameForStore;

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) NSMutableDictionary *uuidCache;

@property(nonatomic, strong) NSMutableArray *cachedSerializedData;
@end