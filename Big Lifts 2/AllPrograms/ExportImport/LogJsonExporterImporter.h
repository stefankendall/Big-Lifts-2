@interface LogJsonExporterImporter : NSObject

+ (NSString *)export;

+ (BOOL)importJson:(NSString *)json;
@end