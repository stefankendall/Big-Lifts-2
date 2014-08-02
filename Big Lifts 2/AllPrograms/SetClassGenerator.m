#import "SetClassGenerator.h"
#import "SetCell.h"
#import "SetCellWithPlates.h"
#import "Purchaser.h"
#import "IAPAdapter.h"
#import "JSettingsStore.h"
#import "JSettings.h"

@implementation SetClassGenerator

+ generate {
    if ([self shouldUseBarLoading]) {
        return SetCellWithPlates.class;
    }
    return SetCell.class;
}

+ (BOOL)shouldUseBarLoading {
    return [[IAPAdapter instance] hasPurchased:IAP_BAR_LOADING] && [[[JSettingsStore instance] first] barLoadingEnabled];
}

@end