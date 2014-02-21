#import "Migrate9to10.h"
#import "JDataHelper.h"
#import "JSSLiftStore.h"

@implementation Migrate9to10

- (void)run {
    [self addCustomNameToStartingStrength];
}

- (void)addCustomNameToStartingStrength {
    NSArray *data = [JDataHelper read:[JSSLiftStore instance]];
    for(NSMutableDictionary *object in data){
        object[@"customName"] = [NSNull null];
    }
    [JDataHelper write:[JSSLiftStore instance] values:data];
}

@end