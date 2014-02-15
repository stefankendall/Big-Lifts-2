@interface JFTOSettingsHelper : NSObject
+ (NSMutableDictionary *)readSettings;

+ (void)writeSettings:(NSDictionary *)settings;
@end