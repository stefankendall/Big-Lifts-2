#import "SetCellWithPlates.h"
#import "JSet.h"
#import "BarCalculator.h"
#import "JBarStore.h"
#import "JBar.h"
#import "JPlateStore.h"
#import "JLift.h"

@implementation SetCellWithPlates

- (void)setSet:(JSet *)set {
    [super setSet:set];

    if (!set.lift.usesBar) {
        [self.platesLabel setText:@""];
        return;
    }

    JBar *bar = [[JBarStore instance] first];
    BarCalculator *calculator = [[BarCalculator alloc] initWithPlates:[[JPlateStore instance] findAll]
                                                            barWeight:bar.weight];

    NSArray *plates = [calculator platesToMakeWeight:[set roundedEffectiveWeight]];
    NSString *platesText = @"";
    if ([plates count] != 0) {
        platesText = [NSString stringWithFormat:@"[%@]", [plates componentsJoinedByString:@", "]];
    }

    [self.platesLabel setText:platesText];
}

@end