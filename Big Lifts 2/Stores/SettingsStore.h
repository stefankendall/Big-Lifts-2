@class Settings;

@interface SettingsStore : NSObject {
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

- (Settings *)settings;

+ (SettingsStore *)instance;
@end

