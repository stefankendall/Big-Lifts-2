#import "SetCell.h"

@class JSJWorkout;
@class JSet;

@interface SJSetCell : SetCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftLabel;
@property(weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property(weak, nonatomic) IBOutlet UILabel *weightRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;

- (void)setSjWorkout:(JSJWorkout *)sjWorkout withSet:(JSet *)set withEnteredWeight:(NSDecimalNumber *)weight;
@end