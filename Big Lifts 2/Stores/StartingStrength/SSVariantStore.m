#import "SSVariantStore.h"
#import "SSVariant.h"

@implementation SSVariantStore

- (void)setupDefaults {
    SSVariant *variant = [self create];
    variant.name = @"Standard";
}

@end