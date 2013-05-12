@interface ContextManager : NSObject {
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic, strong) NSManagedObjectModel *model;

+ (ContextManager *)instance;

+ (NSManagedObjectContext *)context;

+ (NSManagedObjectModel *)model;

- (BOOL)saveChanges;
@end