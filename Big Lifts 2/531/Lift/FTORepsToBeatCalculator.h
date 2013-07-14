@class FTOLift;

@interface FTORepsToBeatCalculator : NSObject

-(int) repsToBeat: (FTOLift *) lift atWeight: (NSDecimalNumber *) weight;

- (NSDecimalNumber *)findLogMax:(FTOLift *)lift;

- (int)findRepsToBeat:(NSDecimalNumber *)number withWeight:(NSDecimalNumber *)weight;
@end