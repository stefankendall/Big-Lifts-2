@class JSONModel;

@interface BLJStore : NSObject

- (Class)modelClass;

- (id)create;

- (void)empty;

- (void)remove:(id)object;

- (void)reset;

- (JSONModel *)deserializeObject:(NSString *)string;

- (void)setupDefaults;

- (void)setDefaultsForObject:(id)object;

- (id)first;

- (id)last;

- (id)find:(NSString *)name value:(id)value;

- (NSArray *)findAll;

- (NSArray *)findAllWhere:(NSString *)name value:(id)value;

- (NSArray *)findAllWithSort:(NSSortDescriptor *)sortDescriptor;

- (id)findBy:(NSPredicate *)predicate;

- (id)atIndex:(int)index;

- (NSNumber *)max:(NSString *)property;

- (void)removeAtIndex:(int)index;

- (int)count;

- (NSOrderedSet *)unique:(NSString *)string;

+ (instancetype)instance;

- (NSArray *)serialize;

- (void)onLoad;

- (void)sync;

- (void)load;

- (NSString *)keyNameForStore;

@property(nonatomic, strong) NSMutableArray *data;

@end