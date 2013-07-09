@class FTOLift;

@interface FTORepsToBeatCalculator : NSObject

-(int) repsToBeat: (FTOLift *) lift atWeight: (NSDecimalNumber *) weight;
@end