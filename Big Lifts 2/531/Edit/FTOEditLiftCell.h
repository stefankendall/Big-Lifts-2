#import "CTCustomTableViewCell/CTCustomTableViewCell.h"
#import "FTOLift.h"

@class RowTextField;
@class TrainingMaxRowTextField;

@interface FTOEditLiftCell : CTCustomTableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftName;

@property(weak, nonatomic) IBOutlet RowTextField *max;
@property(weak, nonatomic) IBOutlet TrainingMaxRowTextField *trainingMax;

- (void)setLift:(Lift *)lift;

- (void)updateTrainingMax:(NSDecimalNumber *)weight;
@end