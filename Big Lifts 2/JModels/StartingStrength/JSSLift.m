#import "JSSLift.h"

@implementation JSSLift

- (NSString *)effectiveName {
    if (self.customName == nil || [self.customName isEqualToString:@""]) {
        return self.name;
    }

    return self.customName;
}

@end