#import "FTOLogExporter.h"

@implementation FTOLogExporter

- (NSData *)logData {
    NSString *csv = @"teststring";
    return [csv dataUsingEncoding:NSUTF8StringEncoding];
}


@end