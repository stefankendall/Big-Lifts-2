#import "JFTOTriumvirateLiftStore.h"
#import "JFTOTriumvirateLift.h"

@implementation JFTOTriumvirateLiftStore

- (Class)modelClass {
    return JFTOTriumvirateLift.class;
}

- (void)liftsChanged {
}

@end