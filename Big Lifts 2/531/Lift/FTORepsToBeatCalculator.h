@class FTOLift;

@interface FTORepsToBeatCalculator : NSObject

-(int) repsToBeat: (FTOLift *) lift atWeight: (NSDecimalNumber *) weight;

- (int)findRepsToBeat:(NSDecimalNumber *)number withWeight:(NSDecimalNumber *)weight;
@end