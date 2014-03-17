#import "FTOFullCustomSetCell.h"
#import "JSet.h"
#import "JLift.h"
#import "BLColors.h"

@implementation FTOFullCustomSetCell

- (void)setSet:(JSet *)set {
    [self.lift setText:set.lift.name];
    [self.percentage setText:[NSString stringWithFormat:@"%@%%", set.percentage]];
    [self.reps setText:[NSString stringWithFormat:@"%@%@", set.reps, set.amrap ? @"+" : @"x"]];
    if (set.amrap) {
        [self.reps setTextColor:[BLColors amrapColor]];
    }
    else {
        [self.reps setTextColor:[UIColor darkGrayColor]];
    }
}

@end