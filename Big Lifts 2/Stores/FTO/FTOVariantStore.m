#import "FTOVariantStore.h"
#import "FTOVariant.h"

@implementation FTOVariantStore

- (void)setupDefaults {
    FTOVariant *variant = [self create];
    variant.name = @"Standard";
}

@end