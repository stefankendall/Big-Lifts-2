#import "StringHelper.h"

@implementation StringHelper

+ (id)nilToEmpty:(NSString *)string {
    return string == nil ? @"" : string;
}

@end