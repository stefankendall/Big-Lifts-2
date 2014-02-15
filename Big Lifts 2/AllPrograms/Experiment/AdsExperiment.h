@interface AdsExperiment : NSObject
+ (BOOL)isInExperiment;

+ (void)placeInExperimentOrNot;
@end