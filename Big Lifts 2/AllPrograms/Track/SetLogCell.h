#import "CTCustomTableViewCell/CTCustomTableViewCell.h"

@class Set;
@class JSetLog;
@class SetLogContainer;

extern int const SET_LOG_CELL_HEIGHT;

@interface SetLogCell : CTCustomTableViewCell
{
}
@property(nonatomic, strong) JSetLog *setLog;
@property (weak, nonatomic) IBOutlet UILabel *liftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@end