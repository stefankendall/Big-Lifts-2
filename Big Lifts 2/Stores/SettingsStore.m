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
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        NSURL *storeUrl = [NSURL fileURLWithPath:[self archivePath]];
        NSError *error = nil;

        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
            [NSException raise:@"Open failed" format:@"%@", [error localizedDescription]];
        }

        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        [context setUndoManager:nil];
    }

    return self;
}

- (NSString *)archivePath {
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentDirectory stringByAppendingPathComponent:@"settings.data"];;
}

- (Settings *)settings {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Settings"];
    [request setEntity:e];

    NSError *error;
    NSArray * result = [context executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"%@", [error localizedDescription]];
    }

    if ([result count] == 0) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:context];
        [defaultSettings setUnits:@"lbs"];
        [self saveChanges];

        return defaultSettings;
    }
    else {
        return result[0];
    }
}

- (BOOL)saveChanges
{
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}


@end