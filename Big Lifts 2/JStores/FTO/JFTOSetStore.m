#import "JFTOSetStore.h"
#import "JFTOSet.h"

@implementation JFTOSetStore

- (Class)modelClass {
    return JFTOSet.class;
}

- (void)setDefaultsForObject:(id)object {
    JFTOSet *set = object;
    set.percentage = N(0);
    set.reps = @0;
}

@end