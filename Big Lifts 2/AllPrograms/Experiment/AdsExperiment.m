#import "AdsExperiment.h"
#import "Purchaser.h"

const NSString *kExperimentKey = @"adsExperiment";

@implementation AdsExperiment

+ (BOOL)isInExperiment {
    return [[NSUserDefaults standardUserDefaults] boolForKey:(NSString *) kExperimentKey];
}

+ (void)placeInExperimentOrNot {
    [[NSUserDefaults standardUserDefaults] setBool:[self shouldBeInExperiment] forKey:(NSString *) kExperimentKey];
}

+ (BOOL)shouldBeInExperiment {
    return ![[Purchaser new] hasPurchasedAnything];
}

@end