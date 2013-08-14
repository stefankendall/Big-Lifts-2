#import "FTOTriumvirateCell.h"
#import "Set.h"
#import "Lift.h"

@implementation FTOTriumvirateCell

- (void)setSet:(Set *)set withCount:(int)count {
    [self.liftLabel setText:set.lift.name];
    [self.repsLabel setText:[NSString stringWithFormat:@"%d reps", [set.reps intValue]]];
    [self.setsLabel setText:[NSString stringWithFormat:@"%d sets", count]];
}

@end
