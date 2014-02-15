@interface JSettingsHelper : NSObject
+ (NSMutableDictionary *)readSettings;

+ (void)writeSettings:(NSDictionary *)settings;
@end