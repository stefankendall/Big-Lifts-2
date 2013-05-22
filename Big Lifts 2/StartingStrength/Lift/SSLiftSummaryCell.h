#import "CustomTableViewCell.h"

@class SSLift;
@class Workout;

@interface SSLiftSummaryCell : CustomTableViewCell
{}
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsAndRepsLabel;

- (void)setWorkout:(Workout *)workout;
@end