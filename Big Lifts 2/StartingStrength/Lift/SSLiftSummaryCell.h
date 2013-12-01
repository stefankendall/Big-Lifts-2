#import "CTCustomTableViewCell.h"

@class JWorkout;

@interface SSLiftSummaryCell : CTCustomTableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *weightLabel;
@property(weak, nonatomic) IBOutlet UILabel *liftLabel;
@property(weak, nonatomic) IBOutlet UILabel *setsAndRepsLabel;

- (void)setWorkout:(JWorkout *)workout;
@end