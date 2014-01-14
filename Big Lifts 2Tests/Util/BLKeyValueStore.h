@interface BLKeyValueStore : NSObject

+ (NSUbiquitousKeyValueStore *)store;

+ (BOOL)iCloudEnabled;

@end