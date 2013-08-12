#import "FTOVariantStore.h"
#import "FTOVariant.h"
#import "FTOWorkoutStore.h"

@implementation FTOVariantStore

- (void)setupDefaults {
    FTOVariant *variant = [self create];
    variant.name = FTO_VARIANT_STANDARD;
}

- (void)changeTo:(NSString *)variant {
    [[self first] setName:variant];
    [[FTOWorkoutStore instance] switchTemplate];
}

@end