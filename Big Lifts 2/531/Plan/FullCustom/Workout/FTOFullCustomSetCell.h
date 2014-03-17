#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@class JSet;

@interface FTOFullCustomSetCell : CTCustomTableViewCell {}
@property (weak, nonatomic) IBOutlet UILabel *lift;
@property (weak, nonatomic) IBOutlet UILabel *reps;
@property (weak, nonatomic) IBOutlet UILabel *percentage;


- (void)setSet:(JSet *)set;
@end