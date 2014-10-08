@class JFTOLift;

@interface FTOLiftsIncrementingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *liftName;
@property (weak, nonatomic) IBOutlet UILabel *increment;
@property (weak, nonatomic) IBOutlet UILabel *endWeight;

- (void)setLift:(JFTOLift *)lift;
@end