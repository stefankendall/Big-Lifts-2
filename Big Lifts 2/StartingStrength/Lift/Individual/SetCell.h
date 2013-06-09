#import "CTCustomTableViewCell.h"

@class Set;

@interface SetCell : CTCustomTableViewCell {
}

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;

- (void)setSet:(Set *) set;
@end