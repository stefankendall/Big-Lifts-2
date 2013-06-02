#import "CustomTableViewCell.h"

@class StepperWithCell;

@interface StepperCell : CustomTableViewCell

@property(weak, nonatomic) IBOutlet StepperWithCell *stepper;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end