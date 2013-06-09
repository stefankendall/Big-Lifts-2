#import "BarCalculator.h"
#import "EnumeratorKit.h"
#import "Plate.h"
#import "PlateRemaining.h"

@interface BarCalculator()
@property(nonatomic, strong) NSArray * plates;
@property(nonatomic) double barWeight;
@end

@implementation BarCalculator

- (BarCalculator *)initWithPlates:(NSArray *)plates barWeight:(double)barWeight {
    if(self = [super init]){
        self.plates = plates;
        self.barWeight = barWeight;
    }
    return self;
}

- (NSArray *)platesToMakeWeight:(double)weight {
    double targetWeight = weight - self.barWeight;
    NSArray *remainingPlates = [self copyPlates:self.plates];
    NSMutableArray *plateWeights = [@[] mutableCopy];

    while (targetWeight > 0) {
        remainingPlates = remainingPlates.filter(^(PlateRemaining *p) {
            BOOL countRemaining = p.count > 0;
            return countRemaining;
        });

        PlateRemaining *nextPlate = [self findPlateClosestToWeight:targetWeight fromPlates:remainingPlates];
        if (nextPlate == nil ) {
            break;
        }
        else {
            [plateWeights addObject:[NSNumber numberWithDouble:nextPlate.weight]];
            nextPlate.count -= 2;
            targetWeight = targetWeight - (2 * nextPlate.weight);
        }
    }

    return plateWeights;
}

- (PlateRemaining *)findPlateClosestToWeight:(double)weight fromPlates:(NSArray *)plates {
    PlateRemaining *firstPlateUnderWeight = plates.find(^(PlateRemaining *p) {
        BOOL underWeight = p.weight * 2 <= weight;
        return underWeight;
    });

    return firstPlateUnderWeight;
}

- (NSArray *)copyPlates:(NSArray *)plates {
    return plates.map(^(Plate *p) {
        return [PlateRemaining fromPlate:p];
    });
}


@end