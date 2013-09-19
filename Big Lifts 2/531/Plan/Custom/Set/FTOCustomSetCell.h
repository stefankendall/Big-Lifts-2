#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@class Set;

@interface FTOCustomSetCell : CTCustomTableViewCell {}
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

- (void)setSet:(Set *)set;
@end