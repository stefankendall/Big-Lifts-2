@interface BLKeyValueStore : NSObject

+ (NSUbiquitousKeyValueStore *)store;

+ (BOOL)iCloudEnabled;

+ (void)forceICloud:(BOOL)on;
@end