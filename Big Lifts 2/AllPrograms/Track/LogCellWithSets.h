#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@class SetLogContainer;
@class SetLog;

@interface LogCellWithSets : CTCustomTableViewCell {}

@property(nonatomic, strong) SetLog *setLog;
@property (weak, nonatomic) IBOutlet UILabel *liftNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

- (void)setSetLogContainer:(SetLogContainer *)setLog;

@end