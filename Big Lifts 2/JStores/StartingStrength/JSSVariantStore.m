#import "JSSVariantStore.h"
#import "JSSVariant.h"

@implementation JSSVariantStore

- (Class)modelClass {
    return JSSVariant.class;
}

- (void)setupDefaults {
    JSSVariant *variant = [self create];
    variant.name = @"Standard";
    variant.warmupEnabled = NO;
}

@end