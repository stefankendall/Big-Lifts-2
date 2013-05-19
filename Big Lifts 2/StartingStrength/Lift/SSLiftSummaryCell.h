#import "CustomTableViewCell.h"

@class SSLift;

@interface SSLiftSummaryCell : CustomTableViewCell
{}
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsAndRepsLabel;

- (void)setLift:(SSLift *)lift;
@end