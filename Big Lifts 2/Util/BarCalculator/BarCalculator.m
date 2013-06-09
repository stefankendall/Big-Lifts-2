#import "BarCalculator.h"
#import "Plate.h"
#import "PlateRemaining.h"
#import "MRCEnumerable.h"

@interface BarCalculator ()
@property(nonatomic, strong) NSArray *plates;
@property(nonatomic) double barWeight;
@end

@implementation BarCalculator

- (BarCalculator *)initWithPlates:(NSArray *)plates barWeight:(double)barWeight {
    if (self = [super init]) {
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
        remainingPlates = [remainingPlates select:^(PlateRemaining *p) {
            BOOL countRemaining = p.count > 0;
            return countRemaining;
        }];

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
    return [plates detect:^BOOL(PlateRemaining *plate) {
        return plate.weight * 2 <= weight;
    }];
}

- (NSArray *)copyPlates:(NSArray *)plates {
    return [plates collect:(^(Plate *p) {
        return [PlateRemaining fromPlate:p];
    })];
}


@end