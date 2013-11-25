#import "JFTOVariantStore.h"
#import "JFTOVariant.h"
#import "FTOVariant.h"
#import "JFTOWorkoutStore.h"

@implementation JFTOVariantStore

- (Class)modelClass {
    return JFTOVariant.class;
}

- (void)setupDefaults {
    JFTOVariant *variant = [self create];
    variant.name = FTO_VARIANT_STANDARD;
}

- (void)changeTo:(NSString *)variant {
    [[self first] setName:variant];
    [[JFTOWorkoutStore instance] switchTemplate];
}

@end