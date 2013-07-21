#import "CTCustomTableViewCell.h"

@class Set;

@interface SetCell : CTCustomTableViewCell {
}

@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionalLabel;

- (void)setSet:(Set *) set;
@end