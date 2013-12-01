#import "FTOTriumvirateCell.h"
#import "JSet.h"
#import "JLift.h"

@implementation FTOTriumvirateCell

- (void)setSet:(JSet *)set withCount:(int)count {
    [self.liftLabel setText:set.lift.name];
    [self.repsLabel setText:[NSString stringWithFormat:@"%d reps", [set.reps intValue]]];
    [self.setsLabel setText:[NSString stringWithFormat:@"%d sets", count]];
}

@end
