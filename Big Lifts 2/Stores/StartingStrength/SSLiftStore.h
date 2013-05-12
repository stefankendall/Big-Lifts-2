#import "BLStore.h"

@interface SSLiftStore : BLStore

+ (SSLiftStore *) instance;

- (void) setupDefaults;

@end