#import "JVersionStore.h"
#import "JVersion.h"

@implementation JVersionStore

- (Class)modelClass {
    return JVersion.class;
}

- (void)setupDefaults {
    JVersion *version = [self create];
    version.version = @18;
}

@end