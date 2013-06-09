@class PlateRemaining;

@interface BarCalculator : NSObject

- (BarCalculator *) initWithPlates: (NSArray *) plates barWeight: (double) weight;

- (NSArray *)platesToMakeWeight:(double)weight;

- (NSArray *)copyPlates:(NSArray *)plates;

- (PlateRemaining *)findPlateClosestToWeight:(double)weight fromPlates:(NSArray *)plates;
@end