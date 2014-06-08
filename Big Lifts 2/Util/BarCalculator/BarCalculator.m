#import "BarCalculator.h"
#import "PlateRemaining.h"
#import "MRCEnumerable.h"
#import "JPlate.h"
#import "DecimalNumberHandlers.h"

@interface BarCalculator ()
@property(nonatomic, strong) NSArray *plates;
@property(nonatomic) NSDecimalNumber *barWeight;
@end

@implementation BarCalculator

- (BarCalculator *)initWithPlates:(NSArray *)plates barWeight:(NSDecimalNumber *)barWeight {
    if (self = [super init]) {
        self.plates = plates;
        self.barWeight = barWeight ? barWeight : N(0);
    }
    return self;
}

- (NSArray *)platesToMakeWeight:(NSDecimalNumber *)weight {
    NSDecimalNumber *targetWeight = [weight decimalNumberBySubtracting:self.barWeight withBehavior:[DecimalNumberHandlers noRaise]];
    NSArray *remainingPlates = [self copyPlates:self.plates];
    NSMutableArray *plateWeights = [@[] mutableCopy];

    PlateRemaining *lastPlate = nil;
    while ([targetWeight compare:N(0)] == NSOrderedDescending) {
        remainingPlates = [remainingPlates select:^(PlateRemaining *p) {
            BOOL countRemaining = p.count > 0;
            return countRemaining;
        }];

        PlateRemaining *nextPlate = [self findPlateClosestToWeight:targetWeight fromPlates:remainingPlates];
        if (nextPlate == nil) {
            if (![targetWeight isEqual:N(0)]) {
                NSArray *platesWithoutLastPlate = [self.plates select:^BOOL(PlateRemaining *plate) {
                    return ![plate.weight isEqual:lastPlate.weight];
                }];
                if ([platesWithoutLastPlate count] > 0) {
                    BarCalculator *calculatorSkippingThisWeight = [[BarCalculator new] initWithPlates:platesWithoutLastPlate barWeight:self.barWeight];
                    NSArray *possibleOtherPlates = [calculatorSkippingThisWeight platesToMakeWeight:weight];
                    plateWeights = [[self platesCloserTo:targetWeight plates1:plateWeights plates2:possibleOtherPlates] mutableCopy];
                }
            }
            break;
        }
        else {
            [plateWeights addObject:nextPlate.weight];
            nextPlate.count -= 2;
            targetWeight = [targetWeight decimalNumberBySubtracting:
                    [nextPlate.weight decimalNumberByMultiplyingBy:N(2)]];
        }
        lastPlate = nextPlate;
    }

    return plateWeights;
}

- (NSArray *)platesCloserTo:(NSDecimalNumber *)target plates1:(NSMutableArray *)plates1 plates2:(NSArray *)plates2 {
    __block NSDecimalNumber *sum1 = N(0);
    [plates1 each:^(NSDecimalNumber *weight) {
        sum1 = [sum1 decimalNumberByAdding:[weight decimalNumberByMultiplyingBy:N(2)]];
    }];

    __block NSDecimalNumber *sum2 = N(0);
    [plates2 each:^(NSDecimalNumber *weight) {
        sum2 = [sum1 decimalNumberByAdding:[weight decimalNumberByMultiplyingBy:N(2)]];
    }];

    NSDecimalNumber *diff1 = [target decimalNumberBySubtracting:sum1];
    NSDecimalNumber *diff2 = [target decimalNumberBySubtracting:sum2];

    if ([diff1 compare:N(0)] == NSOrderedAscending) {
        return plates2;
    }
    if ([diff2 compare:N(0)] == NSOrderedAscending) {
        return plates1;
    }

    if ([diff1 compare:diff2] == NSOrderedAscending) {
        return plates1;
    }
    else {
        return plates2;
    }
}

- (PlateRemaining *)findPlateClosestToWeight:(NSDecimalNumber *)weight fromPlates:(NSArray *)plates {
    return [plates detect:^BOOL(PlateRemaining *plate) {
        NSComparisonResult comparison = [[plate.weight decimalNumberByMultiplyingBy:N(2)] compare:weight];
        return comparison == NSOrderedSame || comparison == NSOrderedAscending;
    }];
}

- (NSMutableArray *)copyPlates:(NSArray *)plates {
    return [[plates collect:(^(JPlate *p) {
        return [PlateRemaining fromPlate:p];
    })] mutableCopy];
}

@end