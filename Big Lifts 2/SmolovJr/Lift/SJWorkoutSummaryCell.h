#import "CTCustomTableViewCell/CTCustomTableViewCell.h"

@class SJWorkout;

@interface SJWorkoutSummaryCell : CTCustomTableViewCell {}

@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *addWeightRangeLabel;

-(void) setWorkout: (SJWorkout *) sjWorkout;

@end