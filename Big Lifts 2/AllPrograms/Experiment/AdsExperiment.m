#import "AdsExperiment.h"
#import "Purchaser.h"

const NSString *kExperimentKey = @"adsExperiment";
const NSString *kOptInKey = @"adsOptInSeen";

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

+ (BOOL)hasSeenOptIn {
    return [[NSUserDefaults standardUserDefaults] boolForKey:(NSString *) kOptInKey];
}

+ (void)setHasSeenOptIn:(BOOL)seen {
    [[NSUserDefaults standardUserDefaults] setBool:seen forKey:(NSString *) kOptInKey];
}

@end