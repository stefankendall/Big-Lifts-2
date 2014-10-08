@class RowTextField;
@class TrainingMaxRowTextField;
@class JLift;

@interface FTOEditLiftCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *liftName;

@property(weak, nonatomic) IBOutlet RowTextField *max;
@property(weak, nonatomic) IBOutlet TrainingMaxRowTextField *trainingMax;

- (void)setLift:(JLift *)lift;

- (void)updateTrainingMax:(NSDecimalNumber *)weight;
@end