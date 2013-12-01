#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@class JSet;

@interface FTOCustomSetCell : CTCustomTableViewCell {}
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

- (void)setSet:(JSet *)set;
@end