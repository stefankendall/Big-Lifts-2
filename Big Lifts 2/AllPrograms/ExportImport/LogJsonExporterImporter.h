@interface LogJsonExporterImporter : NSObject

+ (NSString *)export;

+ (void)importJson:(NSString *)json;
@end