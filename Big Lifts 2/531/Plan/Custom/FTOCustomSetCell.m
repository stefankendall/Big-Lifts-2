#import "FTOCustomSetCell.h"
#import "Set.h"

@implementation FTOCustomSetCell

- (void)setSet:(Set *)set {
    [self.repsLabel setText:[set.reps stringValue]];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", set.percentage]];
}

@end