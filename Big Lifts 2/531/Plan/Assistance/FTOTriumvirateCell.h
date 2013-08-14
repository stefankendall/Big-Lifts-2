#import "CTCustomTableViewCell/CTCustomTableViewCell.h"

@class SetLogContainer;
@class Set;

@interface FTOTriumvirateCell : CTCustomTableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftLabel;
@property(weak, nonatomic) IBOutlet UILabel *setsLabel;
@property(weak, nonatomic) IBOutlet UILabel *repsLabel;

- (void)setSet:(Set *)set withCount: (int) count;

@end
