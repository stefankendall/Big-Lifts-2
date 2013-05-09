@class Settings;

@interface SettingsStore : NSObject {
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

- (Settings *)settings;

- (BOOL)saveChanges;

- (void) empty;

+ (SettingsStore *)instance;
@end

