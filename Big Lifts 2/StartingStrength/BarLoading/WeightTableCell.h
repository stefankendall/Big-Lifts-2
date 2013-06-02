#import "CustomTableViewCell.h"
#import "StepperCell.h"

@interface WeightTableCell : StepperCell
{}
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end