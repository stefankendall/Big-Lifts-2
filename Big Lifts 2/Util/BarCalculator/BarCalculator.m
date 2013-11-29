#import "BarCalculator.h"
#import "PlateRemaining.h"
#import "MRCEnumerable.h"
#import "JPlate.h"

@interface BarCalculator ()
@property(nonatomic, strong) NSArray *plates;
@property(nonatomic) NSDecimalNumber *barWeight;
@end

@implementation BarCalculator

- (BarCalculator *)initWithPlates:(NSArray *)plates barWeight:(NSDecimalNumber *)barWeight {
    if (self = [super init]) {
        self.plates = plates;
        self.barWeight = barWeight;
    }
    return self;
}

- (NSArray *)platesToMakeWeight:(NSDecimalNumber *)weight {
    NSDecimalNumber *targetWeight = [weight decimalNumberBySubtracting:self.barWeight];
    NSArray *remainingPlates = [self copyPlates:self.plates];
    NSMutableArray *plateWeights = [@[] mutableCopy];

    while ([targetWeight compare:N(0)] == NSOrderedDescending) {
        remainingPlates = [remainingPlates select:^(PlateRemaining *p) {
            BOOL countRemaining = p.count > 0;
            return countRemaining;
        }];

        PlateRemaining *nextPlate = [self findPlateClosestToWeight:targetWeight fromPlates:remainingPlates];
        if (nextPlate == nil ) {
            break;
        }
        else {
            [plateWeights addObject:nextPlate.weight];
            nextPlate.count -= 2;
            targetWeight = [targetWeight decimalNumberBySubtracting:
                    [nextPlate.weight decimalNumberByMultiplyingBy:N(2)]];
        }
    }

    return plateWeights;
}

- (PlateRemaining *)findPlateClosestToWeight:(NSDecimalNumber *)weight fromPlates:(NSArray *)plates {
    return [plates detect:^BOOL(PlateRemaining *plate) {
        NSComparisonResult comparison = [[plate.weight decimalNumberByMultiplyingBy:N(2)] compare:weight];
        return comparison == NSOrderedSame || comparison == NSOrderedAscending;
    }];
}

- (NSArray *)copyPlates:(NSArray *)plates {
    return [plates collect:(^(JPlate *p) {
        return [PlateRemaining fromPlate:p];
    })];
}

@end