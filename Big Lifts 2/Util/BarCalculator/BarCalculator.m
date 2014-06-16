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
    NSMutableArray *platesToMakeWeight = [@[] mutableCopy];

    NSArray *potentialSolution = nil;
    while ([targetWeight compare:N(0)] == NSOrderedDescending) {
        remainingPlates = [remainingPlates select:^(PlateRemaining *p) {
            BOOL countRemaining = p.count > 0;
            return countRemaining;
        }];

        PlateRemaining *nextPlate = [self findPlateClosestToWeight:targetWeight fromPlates:remainingPlates];
        if (nextPlate == nil) {
            if ([targetWeight isEqual:N(0)] || potentialSolution != nil) {
                break;
            }
            else {
                potentialSolution = [platesToMakeWeight copy];
                if ([potentialSolution count] > 0) {
                    NSDecimalNumber *lastPlateWeight = [potentialSolution lastObject];
                    targetWeight = [targetWeight decimalNumberByAdding:[lastPlateWeight decimalNumberByMultiplyingBy:N(2)] withBehavior:[DecimalNumberHandlers noRaise]];
                    PlateRemaining *plateForWeight = [remainingPlates detect:^BOOL(PlateRemaining *p) {
                        return [p.weight isEqual:lastPlateWeight];
                    }];
                    plateForWeight.count = 0;
                    [platesToMakeWeight removeObject:lastPlateWeight];
                }
            }
        }
        else {
            [platesToMakeWeight addObject:nextPlate.weight];
            nextPlate.count -= 2;
            targetWeight = [targetWeight decimalNumberBySubtracting:
                    [nextPlate.weight decimalNumberByMultiplyingBy:N(2)]];
        }
    }

    return [self closestSolutionBetween:platesToMakeWeight and:potentialSolution forWeight:targetWeight];
}

- (NSArray *)closestSolutionBetween:(NSMutableArray *)solution1 and:(NSArray *)solution2 forWeight:(NSDecimalNumber *)weight {
    if (solution2 == nil) {
        return solution1;
    }

    NSDecimalNumber *solution1Sum = [self sum: solution1];
    NSDecimalNumber *solution2Sum = [self sum: solution2];

    NSDecimalNumber *solution1Diff = [weight decimalNumberBySubtracting:solution1Sum];
    NSDecimalNumber *solution2Diff = [weight decimalNumberBySubtracting:solution2Sum];

    return [solution1Diff compare:solution2Diff] == NSOrderedAscending ? solution1 : solution2;
}

- (NSDecimalNumber *)sum:(NSMutableArray *)plates {
    NSDecimalNumber *sum = N(0);
    for( NSDecimalNumber *plate in plates ){
        sum = [sum decimalNumberByAdding:[plate decimalNumberByMultiplyingBy:N(2)] withBehavior:[DecimalNumberHandlers noRaise]];
    }
    return sum;
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