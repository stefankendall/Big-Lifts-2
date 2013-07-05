#import "CTCustomTableViewCell/CTCustomTableViewCell.h"
#import "FTOLift.h"

@class RowTextField;

@interface FTOEditLiftCell : CTCustomTableViewCell
{}
@property (weak, nonatomic) IBOutlet UILabel *liftName;
@property (weak, nonatomic) IBOutlet UILabel *trainingWeight;
@property (weak, nonatomic) IBOutlet RowTextField *max;

- (void)setLift:(FTOLift *)lift;

- (void)updateTrainingMax:(NSDecimalNumber *)weight;
@end