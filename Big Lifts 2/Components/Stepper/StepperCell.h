#import "CTCustomTableViewCell.h"

@class StepperWithCell;

@interface StepperCell : CTCustomTableViewCell

@property(weak, nonatomic) IBOutlet StepperWithCell *stepper;
@property(nonatomic, strong) NSIndexPath *indexPath;
@end