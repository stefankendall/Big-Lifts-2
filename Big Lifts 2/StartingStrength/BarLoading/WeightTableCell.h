#import "StepperCell.h"

@class RowUIButton;

@interface WeightTableCell : StepperCell
{}
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitsLabel;

@property (weak, nonatomic) IBOutlet RowUIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *platesLabel;

@end