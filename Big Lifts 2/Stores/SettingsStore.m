#import "SettingsStore.h"
#import "Settings.h"

@implementation SettingsStore

+ (SettingsStore *)instance {
    static SettingsStore *store = nil;
    if (!store) {
        store = (SettingsStore *) [[super allocWithZone:nil] init];
    }
    return store;
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]
                addObserver:self
                   selector:@selector(contentChange:)
                       name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                     object:nil];

        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

        NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        dbPath = [dbPath stringByAppendingPathComponent:@"settings.db"];

        NSURL *dbUrl = [NSURL fileURLWithPath:dbPath];
        NSError *error = nil;

#if (TARGET_IPHONE_SIMULATOR)
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:dbUrl
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
        }
#else
        NSFileManager *fm = [NSFileManager defaultManager];
        NSURL *ubContainer = [fm URLForUbiquityContainerIdentifier:nil];
        NSLog(@"%@", ubContainer);
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        [options setObject:@"Big Lifts 2" forKey:NSPersistentStoreUbiquitousContentNameKey];
        [options setObject:ubContainer forKey:NSPersistentStoreUbiquitousContentURLKey];
if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbUrl options:options error:&error]) {
            [NSException raise:@"Open failed" format:@"%@", [error localizedDescription]];
        }
        #endif

        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        [context setUndoManager:nil];
    }

    return self;
}

- (Settings *)settings {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Settings"];
    [request setEntity:e];

    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"%@", [error localizedDescription]];
    }

    if ([result count] == 0) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:context];
        [defaultSettings setUnits:@"lbs"];
        return defaultSettings;
    }
    else {
        return result[0];
    }
}

- (BOOL)saveChanges {
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

- (void)contentChange:(NSNotification *)note
{
    [context mergeChangesFromContextDidSaveNotification:note];
}

- (void)empty {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [[model entitiesByName] objectForKey:@"Settings"];
    [request setEntity:entity];
    for (NSManagedObject *object in [context executeFetchRequest:request error:nil]) {
        [context deleteObject:object];
    }
}


@end