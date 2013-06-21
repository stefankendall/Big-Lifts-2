@interface BLStore : NSObject

- (id)create;

- (void)contentChange:(NSNotification *)note;

- (void)empty;

- (void)reset;

- (void)setupDefaults;

- (NSString *)modelName;

- (id)first;

- (id)last;

- (id)find:(NSString *)name value:(id)value;

- (NSArray *)findAll;

- (NSArray *)findAllWithSort:(NSSortDescriptor *)sortDescriptor;

- (id)findBy:(NSPredicate *)predicate;

- (id)atIndex:(int)index;

- (void)removeAtIndex:(int)index;

- (int)count;

+ (instancetype)instance;

- (void)onLoad;

- (void)fireChanged;

- (void)registerChangeListener:(void (^)(void))callback;

@property(nonatomic, strong) NSMutableSet *changeCallbacks;
@end