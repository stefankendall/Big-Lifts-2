#import "CTCustomTableViewCell/CTCustomTableViewCell.h"
#import "FTOLift.h"

@class RowTextField;
@class TrainingMaxRowTextField;
@class JLift;

@interface FTOEditLiftCell : CTCustomTableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftName;

@property(weak, nonatomic) IBOutlet RowTextField *max;
@property(weak, nonatomic) IBOutlet TrainingMaxRowTextField *trainingMax;

- (void)setLift:(JLift *)lift;

- (void)updateTrainingMax:(NSDecimalNumber *)weight;
@end