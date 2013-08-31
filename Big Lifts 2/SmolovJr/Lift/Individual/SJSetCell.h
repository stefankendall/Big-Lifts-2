#import "SetCell.h"

@class SJWorkout;

@interface SJSetCell : SetCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftLabel;
@property(weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property(weak, nonatomic) IBOutlet UILabel *weightRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;

- (void)setSjWorkout:(SJWorkout *)sjWorkout withSet:(Set *)set;
@end