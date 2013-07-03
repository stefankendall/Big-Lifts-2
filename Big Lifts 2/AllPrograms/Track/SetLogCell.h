#import "CTCustomTableViewCell/CTCustomTableViewCell.h"

@class Set;
@class SetLog;
@class SetLogContainer;

extern int const SET_LOG_CELL_HEIGHT;

@interface SetLogCell : CTCustomTableViewCell
{
}
@property(nonatomic, strong) SetLog *setLog;
@property (weak, nonatomic) IBOutlet UILabel *liftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

- (void)setSetLogContainer:(SetLogContainer *)setLog;
@end