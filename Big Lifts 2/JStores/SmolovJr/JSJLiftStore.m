#import "JSJLiftStore.h"
#import "JSJLift.h"

@implementation JSJLiftStore

- (Class)modelClass {
    return JSJLift.class;
}

- (void)setupDefaults {
    [self create];
}

@end