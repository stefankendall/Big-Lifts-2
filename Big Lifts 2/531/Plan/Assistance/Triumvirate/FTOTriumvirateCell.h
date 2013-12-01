#import "CTCustomTableViewCell/CTCustomTableViewCell.h"

@class SetLogContainer;
@class JSet;

@interface FTOTriumvirateCell : CTCustomTableViewCell {
}
@property(weak, nonatomic) IBOutlet UILabel *liftLabel;
@property(weak, nonatomic) IBOutlet UILabel *setsLabel;
@property(weak, nonatomic) IBOutlet UILabel *repsLabel;

- (void)setSet:(JSet *)set withCount: (int) count;

@end
