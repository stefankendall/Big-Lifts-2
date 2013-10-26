@class PlateRemaining;

@interface BarCalculator : NSObject

- (BarCalculator *) initWithPlates: (NSArray *) plates barWeight: (NSDecimalNumber *) weight;

- (NSArray *)platesToMakeWeight:(NSDecimalNumber *)weight;

- (NSArray *)copyPlates:(NSArray *)plates;

- (PlateRemaining *)findPlateClosestToWeight:(NSDecimalNumber *)weight fromPlates:(NSArray *)plates;
@end