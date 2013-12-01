#import "FTOCustomSetCell.h"
#import "JSet.h"

@implementation FTOCustomSetCell

- (void)setSet:(JSet *)set {
    NSString *reps = [set.reps stringValue];

    if( set.amrap ){
        reps = [reps stringByAppendingString:@"+"];
        [self.repsLabel setTextColor:[UIColor greenColor]];
    }
    else {
        [self.repsLabel setTextColor:[UIColor blackColor]];
    }

    [self.repsLabel setText:reps];
    [self.percentageLabel setText:[NSString stringWithFormat:@"%@%%", set.percentage]];
}

@end