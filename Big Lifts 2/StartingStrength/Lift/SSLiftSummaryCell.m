#import "SSLiftSummaryCell.h"
#import "SSLift.h"

@implementation SSLiftSummaryCell
@synthesize liftLabel;

- (void)setLift:(SSLift *)lift {
    [liftLabel setText:lift.name];
}
@end