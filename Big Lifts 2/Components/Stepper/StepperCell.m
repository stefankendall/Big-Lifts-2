#import "StepperCell.h"
#import "StepperWithCell.h"

@implementation StepperCell
@synthesize stepper, indexPath;

- (void)awakeFromNib {
    [super awakeFromNib];
    stepper.cell = self;
}


@end