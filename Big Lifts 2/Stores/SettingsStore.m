#import "SettingsStore.h"
#import "Settings.h"
#import "ContextManager.h"

@implementation SettingsStore

+ (SettingsStore *)instance {
    static SettingsStore *store = nil;
    if (!store) {
        store = (SettingsStore *) [[super allocWithZone:nil] init];
    }
    return store;
}

- (NSString *)modelName {
    return @"Settings";
}

- (Settings *)settings {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [[[ContextManager  model] entitiesByName] objectForKey:@"Settings"];
    [request setEntity:e];

    NSError *error;
    NSArray *result = [[ContextManager context] executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch Failed" format:@"%@", [error localizedDescription]];
    }

    if ([result count] == 0) {
        Settings *defaultSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:[ContextManager context]];
        [defaultSettings setUnits:@"lbs"];
        return defaultSettings;
    }
    else {
        return result[0];
    }
}

@end