#import "SetCellWithPlates.h"
#import "JSet.h"
#import "BarCalculator.h"
#import "JBarStore.h"
#import "JBar.h"
#import "JPlateStore.h"
#import "JLift.h"
#import "DecimalNumberHelper.h"

@implementation SetCellWithPlates

- (void)setSet:(JSet *)set {
    [super setSet:set];

    if (!set.lift.usesBar) {
        [self.platesLabel setText:@""];
        return;
    }

    NSDecimalNumber *weightToMake = [set roundedEffectiveWeight];
    [self setPlatesTextForWeight:weightToMake];
}

- (void)setPlatesTextForWeight:(NSDecimalNumber *)weightToMake {
    JBar *bar = [[JBarStore instance] first];
    BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:[[JPlateStore instance] findAll]
                                                            barWeight:bar.weight];
    weightToMake = [DecimalNumberHelper nanOrNil:self.enteredWeight] ? weightToMake : self.enteredWeight;
    NSArray *plates = [calculator platesToMakeWeight:weightToMake];
    NSString *platesText = @"";
    if ([plates count] != 0) {
        platesText = [NSString stringWithFormat:@"[%@]", [plates componentsJoinedByString:@", "]];
    }

    [self.platesLabel setText:platesText];
}

- (void)updateWeight:(NSDecimalNumber *)weight {
    [super updateWeight:weight];
    [self setPlatesTextForWeight:weight];
}

@end