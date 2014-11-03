#import "LogJsonExporterImporter.h"

@implementation LogJsonExporterImporter

+ (NSString *)export {
    return @"A B C hello";
}

+ (void)importJson:(NSString *)json {
    NSLog(@"%@", json);
}

@end