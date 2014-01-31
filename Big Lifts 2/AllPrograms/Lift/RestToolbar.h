#import <CTCustomTableViewCell/CTCustomTableViewCell.h>

@interface RestToolbar : CTCustomTableViewCell {}
@property (weak, nonatomic) IBOutlet UIButton *timerButton;

- (void)updateTime;
@end