@interface JFTOSettingsHelper : NSObject
+ (NSMutableDictionary *)readSettings: (id) store;

+ (void)writeSettings:(NSDictionary *)settings forStore: (id)store;
@end