@interface AdsExperiment : NSObject
+ (BOOL)isInExperiment;

+ (void)placeInExperimentOrNot;

+ (BOOL)hasSeenOptIn;

+ (void)setHasSeenOptIn:(BOOL)b;
@end