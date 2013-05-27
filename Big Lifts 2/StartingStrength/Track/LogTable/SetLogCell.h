#import "CustomTableViewCell.h"

@class Set;
@class SetLog;

extern int const SET_LOG_CELL_HEIGHT;

@interface SetLogCell : CustomTableViewCell
{
}
@property(nonatomic, strong) SetLog *setLog;
@property (weak, nonatomic) IBOutlet UILabel *liftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

- (void)setSetLog:(SetLog *)setLog;
@end