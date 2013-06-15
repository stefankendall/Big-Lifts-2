#import "ContextManager.h"

@implementation ContextManager
@synthesize context, model;

+ (ContextManager *)instance {
    static ContextManager *manager = nil;
    if (!manager) {
        manager = (ContextManager *) [[super allocWithZone:nil] init];
    }
    return manager;
}

+ (NSManagedObjectContext *)context {
    return [[self instance] context];
}

+ (NSManagedObjectModel *)model {
    return [[self instance] model];
}


- (id)init {
    self = [super init];
    if (self) {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

        NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        dbPath = [dbPath stringByAppendingPathComponent:@"biglifts.db"];
        NSURL *dbUrl = [NSURL fileURLWithPath:dbPath];

//#if (TARGET_IPHONE_SIMULATOR)
NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:dbUrl
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
        }
        context = [[NSManagedObjectContext alloc] init];
            [context setPersistentStoreCoordinator:psc];
            [context setUndoManager:nil];
//#else
//            [self setupICloud: dbUrl withPsc: psc];
//#endif
    }

    return self;
}

- (void)setupICloud: (NSURL *) dbUrl withPsc: psc {
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *ubContainer = [fm URLForUbiquityContainerIdentifier:nil];
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    [options setObject:@"Big Lifts 2" forKey:NSPersistentStoreUbiquitousContentNameKey];
    [options setObject:ubContainer forKey:NSPersistentStoreUbiquitousContentURLKey];
    [options setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
    [options setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];

    NSLog(@"Opening database...%@", ubContainer);
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbUrl options:options error:&error]) {
        NSLog(@"Did not open...");
        [self logStartupError:error];
        [NSException raise:@"Open failed" format:@"%@", [error localizedDescription]];
    }
    NSLog(@"Started!");
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:psc];
    [context setUndoManager:nil];
}

- (void)logStartupError:(NSError *)error {
    NSDictionary *ui = [error userInfo];
    for (NSString *err in [ui keyEnumerator]) {
        NSLog(@"err:%@", [ui objectForKey:err]);
    }
}

- (BOOL)saveChanges {
    NSError *err = nil;
    BOOL successful = [[[ContextManager instance] context] save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}


@end